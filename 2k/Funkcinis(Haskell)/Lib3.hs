{-# LANGUAGE FlexibleInstances #-}

module Lib3 where

import Data.Either as E (Either (..))
import Data.List as L (lookup)
import Lib2 (JsonLike (..), parseJsonMessage)

-- Keep this type as is
type GameId = String

-- Keep these classes as is:
-- You will want to implement instances for them
class ToJsonLike a where
  toJsonLike :: a -> Either String JsonLike

class FromJsonLike a where
  fromJsonLike :: JsonLike -> Either String a

class ContainsGameId a where
  gameId :: a -> GameId

-- Further it is your code: you can change whatever you wish

-- Converts a JsonLike into a String: renders json
instance FromJsonLike String where
  fromJsonLike (JsonLikeObject a) = E.Right $ fromJsonLikeObjectToString a
  fromJsonLike v = E.Left $ "Couldnt convert to string " ++ show v
-- Acts as a parser from a String

-- toJsonLike respStr & e & fromJsonLike

instance ToJsonLike String where
  toJsonLike = Lib2.parseJsonMessage

type Height = Int 
type Width = Int


data NewGame = NewGame Height GameId Width
  deriving (Show)

instance ContainsGameId NewGame where
  gameId (NewGame height gid width) = gid

instance FromJsonLike NewGame where
  fromJsonLike o@(JsonLikeObject m) = do
    uuid <- getStringFromJsonLikeList o "uuid"
    height <- getIntFromJsonLikeList o "height"
    width <- getIntFromJsonLikeList o "width"
    return $ NewGame (fromIntegral height) uuid (fromIntegral width)
  fromJsonLike a = E.Left $ "Wrong jsonLikeObject " ++ show a

data Direction = Right | Left | Up | Down
  deriving (Show)

data Command
  = MoveBomberman Direction
  | FetchSurrounding
  | PlantBomb
  | FetchBombStatus
  | FetchBombSurrounding
  deriving (Show)

data Commands = Commands
  { command :: Command,
    additional :: Maybe Commands
  }
  deriving (Show)

instance ToJsonLike Commands where
  toJsonLike a = E.Right $ JsonLikeObject [("command", JsonLikeObject[("name", JsonLikeString "FetchSurrounding"), ("additional", JsonLikeNull)])]
  --toJsonLike _ = E.Left $ 

instance FromJsonLike Commands where
  fromJsonLike _ = E.Left "FromJsonLike commands"

newtype CommandsResponse = CommandsResponse String
  deriving (Show)

instance ToJsonLike CommandsResponse where
  toJsonLike (CommandsResponse a) = toJsonLike a

instance FromJsonLike CommandsResponse where
  fromJsonLike (JsonLikeObject a) = E.Right $ CommandsResponse (fromJsonLikeObjectToString a)
  fromJsonLike v = E.Left $ "Wrong command response" ++ show v


------------------------- HELPER FUNCTIONS --------------------------------

fromJsonLikeObjectToString :: [(String, JsonLike)] -> String
fromJsonLikeObjectToString ((name, (JsonLikeString str)) : xs) =
  "{\"" ++ name ++ "\":\"" ++ str ++ "\"" ++ fromJsonLikeObjectToString' xs ++ "}"
fromJsonLikeObjectToString ((name, (JsonLikeNull)) : xs) =
  "{\"" ++ name ++ "\":\"null\"" ++ fromJsonLikeObjectToString' xs ++ "}"
fromJsonLikeObjectToString ((name, (JsonLikeInteger a)) : xs) =
  "{\"" ++ name ++ "\":\"" ++ show a ++ "\"" ++ fromJsonLikeObjectToString' xs ++ "}"
fromJsonLikeObjectToString ((name, (JsonLikeObject str)) : xs) =
  "{\"" ++ name ++ "\":" ++ fromJsonLikeObjectToString str ++ fromJsonLikeObjectToString' xs ++ "}"
fromJsonLikeObjectToString ((name, JsonLikeList list) : xs) =
  "{\"" ++ name ++ "\":" ++ printJsonLikeList (JsonLikeList list) ++ fromJsonLikeObjectToString' xs ++ "}"
fromJsonLikeObjectToString _ = "{}"

printJsonLikeList :: JsonLike -> String
printJsonLikeList (JsonLikeList ((JsonLikeInteger x) : xs)) = "[" ++ show x ++ printJsonLikeList' (JsonLikeList xs)
printJsonLikeList (JsonLikeList []) = "[]"
printJsonLikeList _ = ""

printJsonLikeList' :: JsonLike -> String
printJsonLikeList' (JsonLikeList ((JsonLikeInteger x) : xs)) = "," ++ show x ++ printJsonLikeList' (JsonLikeList xs)
printJsonLikeList' (JsonLikeList []) = "]"
printJsonLikeList' _ = ""

fromJsonLikeObjectToString' :: [(String, JsonLike)] -> String
fromJsonLikeObjectToString' ((name, (JsonLikeString str)) : xs) = 
  ",\"" ++ name ++ "\":\"" ++ str ++ "\"" ++ fromJsonLikeObjectToString' xs
fromJsonLikeObjectToString' ((name, (JsonLikeNull)) : xs) = 
  ",\"" ++ name ++ "\":\"null\"" ++ fromJsonLikeObjectToString' xs
fromJsonLikeObjectToString' ((name, (JsonLikeInteger a)) : xs) = 
  ",\"" ++ name ++ "\":\"" ++ show a ++ "\"" ++ fromJsonLikeObjectToString' xs
fromJsonLikeObjectToString' ((name, (JsonLikeObject obj)) : xs) = 
  ",\"" ++ name ++ "\":" ++ fromJsonLikeObjectToString obj ++ fromJsonLikeObjectToString' xs
fromJsonLikeObjectToString' _ = []


getStringFromJsonLikeList :: JsonLike -> String -> Either [Char] String
getStringFromJsonLikeList o@(JsonLikeObject m) str = 
  case L.lookup str m of
    Nothing -> E.Left $ "no str field in " ++ show otherwise 
    Just (JsonLikeString a) -> E.Right a
    _ -> E.Left "Error in getting value from list"
getStringFromJsonLikeList a _ = E.Left $ "Wrong json like list" ++ show a

getIntFromJsonLikeList :: JsonLike -> String -> Either [Char] Integer
getIntFromJsonLikeList o@(JsonLikeObject m) str = 
  case L.lookup str m of
    Nothing -> E.Left $ "no str field in " ++ show otherwise 
    Just (JsonLikeInteger a) -> E.Right a
    _ -> E.Left "Error in getting value from list"
getIntFromJsonLikeList a _ = E.Left $ "Wrong json like list" ++ show a

temp = "{\"bomb\":null,\"bomb_surrounding\":null,\"surrounding\":{\"bombermans\":{\"head\":[1,1],\"tail\":{\"head\":null,\"tail\":null}},\"bricks\":{\"head\":[8,7],\"tail\":{\"head\":[8,3],\"tail\":{\"head\":[8,1],\"tail\":{\"head\":[6,7],\"tail\":{\"head\":[6,5],\"tail\":{\"head\":[5,8],\"tail\":{\"head\":[5,4],\"tail\":{\"head\":[3,6],\"tail\":{\"head\":[3,4],\"tail\":{\"head\":[2,3],\"tail\":{\"head\":[2,1],\"tail\":{\"head\":[1,8],\"tail\":{\"head\":[1,7],\"tail\":{\"head\":[1,6],\"tail\":{\"head\":null,\"tail\":null}}}}}}}}}}}}}}},\"gates\":{\"head\":null,\"tail\":null},\"ghosts\":{\"head\":null,\"tail\":null},\"wall\":{\"head\":[8,8],\"tail\":{\"head\":[8,6],\"tail\":{\"head\":[8,4],\"tail\":{\"head\":[8,2],\"tail\":{\"head\":[8,0],\"tail\":{\"head\":[7,0],\"tail\":{\"head\":[6,8],\"tail\":{\"head\":[6,6],\"tail\":{\"head\":[6,4],\"tail\":{\"head\":[6,2],\"tail\":{\"head\":[6,0],\"tail\":{\"head\":[5,0],\"tail\":{\"head\":[4,8],\"tail\":{\"head\":[4,6],\"tail\":{\"head\":[4,4],\"tail\":{\"head\":[4,2],\"tail\":{\"head\":[4,0],\"tail\":{\"head\":[3,0],\"tail\":{\"head\":[2,8],\"tail\":{\"head\":[2,6],\"tail\":{\"head\":[2,4],\"tail\":{\"head\":[2,2],\"tail\":{\"head\":[2,0],\"tail\":{\"head\":[1,0],\"tail\":{\"head\":[0,8],\"tail\":{\"head\":[0,7],\"tail\":{\"head\":[0,6],\"tail\":{\"head\":[0,5],\"tail\":{\"head\":[0,4],\"tail\":{\"head\":[0,3],\"tail\":{\"head\":[0,2],\"tail\":{\"head\":[0,1],\"tail\":{\"head\":[0,0],\"tail\":{\"head\":null,\"tail\":null}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
jsonLikeTemp = JsonLikeObject [("bomb",JsonLikeNull),("bomb_surrounding",JsonLikeNull),("surrounding",JsonLikeObject [("bombermans",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 1,JsonLikeInteger 1]),("tail",JsonLikeObject [("head",JsonLikeNull),("tail",JsonLikeNull)])]),("bricks",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 7]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 3]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 1]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 7]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 5]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 5,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 5,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 3,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 3,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 3]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 1]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 1,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 1,JsonLikeInteger 7]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 1,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeNull),("tail",JsonLikeNull)])])])])])])])])])])])])])])]),("gates",JsonLikeObject [("head",JsonLikeNull),("tail",JsonLikeNull)]),("ghosts",JsonLikeObject [("head",JsonLikeNull),("tail",JsonLikeNull)]),("wall",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 2]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 8,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 7,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 2]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 6,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 5,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 4,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 4,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 4,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 4,JsonLikeInteger 2]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 4,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 3,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 2]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 2,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 1,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 8]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 7]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 6]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 5]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 4]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 3]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 2]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 1]),("tail",JsonLikeObject [("head",JsonLikeList [JsonLikeInteger 0,JsonLikeInteger 0]),("tail",JsonLikeObject [("head",JsonLikeNull),("tail",JsonLikeNull)])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])])]

jsonLike1 = JsonLikeObject [("bomb",JsonLikeNull),("shit",JsonLikeNull )]