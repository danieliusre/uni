module Main where

import Control.Exception (bracket)
import Control.Lens ((^.))
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import Data.Either as E (either, Either (Left, Right))
import Data.Function ((&))
import Data.List as L (concat, (++))
import Data.String.Conversions (cs)
import Network.Wreq (post, responseBody)
import Network.Wreq.Lens (Response (..))
import qualified Network.Wreq.Session as Sess
import System.Console.ANSI as ANSI
  ( clearScreen,
    hideCursor,
    setCursorPosition,
    showCursor,
  )
import System.IO (BufferMode (..), hSetBuffering, hSetEcho, stderr, stdin, stdout)
import Prelude hiding (Left, Right)
import qualified Lib2
import Lib2 (InitData(gameWidth, gameHeight), render, State)
import Lib3
    ( Command(FetchSurrounding, MoveBomberman),
      Commands(Commands),
      CommandsResponse,
      ContainsGameId(gameId),
      FromJsonLike(..),
      GameId,
      NewGame (NewGame),
      ToJsonLike(..),
      Direction(..)
      )
import Control.Concurrent (Chan, forkIO)

-- MANDATORY CODE
host :: String
host = "http://bomberman.homedir.eu"

createGame ::
  (FromJsonLike a) =>
  Sess.Session ->
  IO a
createGame sess = do
  r <- Sess.post sess (host ++ "/v1/game/new/random") B.empty
  let resp = cs $ r ^. responseBody :: String
  return $ toJsonLike resp & e & fromJsonLike & e

postCommands ::
  (FromJsonLike a, ToJsonLike a, FromJsonLike b, ToJsonLike b) =>
  GameId ->
  Sess.Session ->
  a ->
  IO b
postCommands uuid sess commands = do
  let str = toJsonLike commands & e & fromJsonLike & e :: String
  let req = cs str :: B.ByteString
  r <- Sess.post sess (L.concat [host, "/v3/game/", uuid]) req
  let respStr = cs $ r ^. responseBody :: String
  return $ toJsonLike respStr & e & fromJsonLike & e

e :: Either String a -> a
e = E.either error id

-- MANDATORY CODE END

main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stderr NoBuffering
  hSetBuffering stdout NoBuffering
  hSetEcho stdin False
  bracket
    (ANSI.hideCursor >> Sess.newAPISession)
    (const showCursor)
    ( \sess -> do
        -- you are free to do whatever you want but:
        -- a) reuse sess (connection to the server)
        -- b) use createGame and postCommands to interact with the game server
        game <- createGame sess :: IO NewGame
        let commands = Commands FetchSurrounding Nothing :: Commands
        initSurr <- postCommands (gameId game) sess commands :: IO CommandsResponse
        case toJsonLike initSurr of
          E.Left e -> error e
          E.Right a -> do
            let initialState = Lib2.init (initData game) a
            draw initialState
            --forkIO $ loop $

            --let initState = Lib2.init

        --print $ toJsonLike initSurr
    )


loop :: Sess.Session -> NewGame -> State -> IO ()
loop sess game state = do
  c <- getChar
  let commands = case c of
        'a' -> Commands (MoveBomberman Lib3.Left) getAllInfo
        's' -> Commands (MoveBomberman Lib3.Down) getAllInfo
        'd' -> Commands (MoveBomberman Lib3.Right) getAllInfo
        'w' -> Commands (MoveBomberman Lib3.Up) getAllInfo
        'b' -> Commands (PlantBomb) getAllInfo
        _ -> Commands FetchSurrounding getAllInfo
  forkIO (detonateBomb sess game state commands)
  r <- postCommands (gameId game) sess commands :: IO CommandsResponse 
  case Lib2.parseJsonMessage r of
    E.Left e -> error e
    E.Right jl -> do
      let newState = Lib2.update state jl
      _ <- draw newState
      loop sess game newState
      --loop uuid sess newState

getAllInfo :: Maybe Commands
getAllInfo = Just (Commands FetchSurrounding (Just (Commands FetchBombStatus Nothing)))
{- writer :: Chan Lib2.State -> IO ()
writer ch = do -}
  

initData :: NewGame -> Lib2.InitData 
initData game = 
  let (NewGame  h _ w) = game
  in Lib2.InitData {gameWidth = w, gameHeight = h}

draw :: Lib2.State -> IO ()
draw state = do
  _ <- ANSI.clearScreen
  _ <- ANSI.setCursorPosition 0 0
  putStrLn $ render state


detonateBomb :: Sess.Session -> NewGame -> State -> Commands -> IO ()
detonateBomb sess game state commands =
  case commands FetchBombStatus of
    False -> return()
    _ -> do
      threadDelay(5 * 1000000)
      r <- postCommands (gameId game) sess FetchSurrounding getAllInfo
      case toJsonLike r of
        E.Left e -> error e
        E.Right jl -> do
          let newState = Lib2.update state jl
          _ <- draw newState
          return()