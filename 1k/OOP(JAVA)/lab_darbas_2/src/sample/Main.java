package sample;

import javafx.application.Application;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.io.File;
import java.security.Principal;
import java.text.NumberFormat;
import java.awt.*;

public class Main extends Application {

    private TextField PrincipalField;
    private TextField PeriodField;
    private TextField InterestRateField;
    Button CalculateButton;
    Button GraphButton;
    Button TableButton;
    Button FileButton;
    private Text MortgageFinal;
    private Text AnualFinal;
    private String mortgageFormatted;
    private Pane root;

    @Override
    public void start(Stage primaryStage) throws Exception{
        primaryStage.setTitle("Mortgage Calculator");
        CalculateButton = new Button();
        CalculateButton.setText("Apskaičiuoti");
        GraphButton = new Button();
        GraphButton.setText("Grafikas");
        TableButton = new Button();
        TableButton.setText("Lentelė");
        FileButton = new Button();
        FileButton.setText("Sukurti failą");

        Text StageName = new Text(175, 50, "Paskolos skaičiuoklė");
        StageName.setFill(Color.BLACK);
        StageName.setStyle("-fx-font: 24 arial;");

        Text TextPrincipal = new Text(50, 100, "Paskolos suma (€):");
        TextPrincipal.setStyle("-fx-font: 16 arial;");
        TextField PrincipalField = new TextField();
        PrincipalField.setStyle("-fx-font: 16 arial;");
        PrincipalField.setLayoutX(190);
        PrincipalField.setLayoutY(80);

        Text TextPeriod = new Text(50, 150, "Laikotarpio trukmė (mėnesiais):");
        TextPeriod.setStyle("-fx-font: 16 arial;");
        TextField PeriodField = new TextField();
        PeriodField.setStyle("-fx-font: 16 arial;");
        PeriodField.setMaxSize(100, 50);
        PeriodField.setLayoutX(280);
        PeriodField.setLayoutY(130);

        Text TextInterestRate = new Text(50, 200, "Metinė palūkanų norma (%):");
        TextInterestRate.setStyle("-fx-font: 16 arial;");
        TextField InterestRateField = new TextField();
        InterestRateField.setStyle("-fx-font: 16 arial;");
        InterestRateField.setMaxSize(100, 50);
        InterestRateField.setLayoutX(255);
        InterestRateField.setLayoutY(180);

        Text TextChooseGraph = new Text(50, 250, "Paskolos grąžinimo grafikas:");
        TextChooseGraph.setStyle("-fx-font: 16 arial;");

        ToggleGroup group = new ToggleGroup();
        RadioButton AnuitetoButton = new RadioButton("Anuiteto");
        AnuitetoButton.setLayoutX(260);
        AnuitetoButton.setLayoutY(235);
        AnuitetoButton.setToggleGroup(group);
        AnuitetoButton.setSelected(true);
        RadioButton LinijinisButton = new RadioButton("Linijinis");
        LinijinisButton.setToggleGroup(group);
        LinijinisButton.setLayoutX(350);
        LinijinisButton.setLayoutY(235);

        Text PrincipalError = new Text(400, 100, "*Laukelį būtina užpildyti*");
        PrincipalError.setStyle("-fx-font: 12 arial");
        PrincipalError.setFill(Color.RED);
        Text PeriodError = new Text(385, 150, "*Laukelį būtina užpildyti*");
        PeriodError.setStyle("-fx-font: 12 arial");
        PeriodError.setFill(Color.RED);
        Text InterestError = new Text(360, 200, "*Laukelį būtina užpildyti*");
        InterestError.setStyle("-fx-font: 12 arial");
        InterestError.setFill(Color.RED);

        Text PrincipalValueError = new Text(400, 95, "*Įveskite skaičių nuo \n 1 000 iki 10 000 000*");
        PrincipalValueError.setStyle("-fx-font: 12 arial");
        PrincipalValueError.setFill(Color.RED);
        Text PeriodValueError = new Text(385, 150, "*Įveskite skaičių nuo 1 iki 400*");
        PeriodValueError.setStyle("-fx-font: 12 arial");
        PeriodValueError.setFill(Color.RED);
        Text InterestValueError = new Text(360, 200, "*Įveskite skaičių nuo 1 iki 10*");
        InterestValueError.setStyle("-fx-font: 12 arial");
        InterestValueError.setFill(Color.RED);

        CalculateButton.setLayoutX(250);
        CalculateButton.setLayoutY(270);

        GraphButton.setLayoutX(340);
        GraphButton.setLayoutY(310);
        GraphButton.setMinSize(100,60);

        FileButton.setLayoutX(500);
        FileButton.setLayoutY(360);

        Pane root = new AnchorPane();
        root.getChildren().addAll(StageName, TextPrincipal, PrincipalField, TextPeriod,  PeriodField, TextInterestRate, InterestRateField, TextChooseGraph, AnuitetoButton, LinijinisButton, CalculateButton);

        PrincipalField.textProperty().addListener(new ChangeListener<String>() {
            @Override
            public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
                if (!newValue.matches("\\d*")) {
                    PrincipalField.setText(newValue.replaceAll("[^\\d]", ""));
                }
            }
        });

        PeriodField.textProperty().addListener(new ChangeListener<String>() {
            @Override
            public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
                if (!newValue.matches("\\d*")) {
                    PeriodField.setText(newValue.replaceAll("[^\\d]", ""));
                }
            }
        });

        InterestRateField.textProperty().addListener(new ChangeListener<String>() {
            @Override
            public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
                if (!newValue.matches("\\d*") || (!newValue.matches("\\."))) {
                    InterestRateField.setText(newValue.replaceAll("[^\\d.]", ""));
                }
            }
        });

        CalculateButton.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent actionEvent) {
                root.getChildren().removeAll(PrincipalError, PeriodError, InterestError);
                root.getChildren().removeAll(PrincipalValueError, PeriodValueError, InterestValueError);
                    if (Input.activateButton(PrincipalField, InterestRateField, PeriodField, LinijinisButton, AnuitetoButton) && Input.allValid(PrincipalField, PeriodField, InterestRateField)) {
                        if (actionEvent.getSource() == CalculateButton) {
                            root.getChildren().removeAll(AnualFinal, MortgageFinal, TableButton, GraphButton, FileButton);
                            double principal = Double.parseDouble(PrincipalField.getText());
                            double annualInterest = Double.parseDouble(InterestRateField.getText());
                            int n = (int) Double.parseDouble(PeriodField.getText());

                            double mortgageUp;
                            double mortgageDown;
                            double mortgage;
                            double monthlyInterest = annualInterest / 100 / 12;

                            if (AnuitetoButton.isSelected()) {
                                mortgageUp = Math.pow((1 + monthlyInterest), n) * monthlyInterest;
                                mortgageDown = Math.pow((1 + monthlyInterest), n) - 1;
                                mortgage = principal * mortgageUp / mortgageDown;
                                LoanData loadData = new LoanData(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton);
                                AnualFinal = new Text("Viso mokėti: " + NumberFormat.getCurrencyInstance().format(mortgage * n));
                                mortgageFormatted = NumberFormat.getCurrencyInstance().format(mortgage);
                                MortgageFinal = new Text("Mėnesinė įmoka: " + mortgageFormatted);
                            } else {
                                TableButton.setLayoutX(230);
                                TableButton.setLayoutY(320);
                                LoanData loanData = new LoanData(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton);
                                loanData.calculateLinear();
                                mortgage = loanData.BankEarned + loanData.TotalPaid;
                                AnualFinal = new Text("Viso mokėti: " + NumberFormat.getCurrencyInstance().format(mortgage));
                                MortgageFinal = new Text("Mėnesinės įmokos: ");
                                root.getChildren().add(TableButton);
                            }
                            MortgageFinal.setStyle("-fx-font: 20 arial;");
                            MortgageFinal.setLayoutX(50);
                            MortgageFinal.setLayoutY(340);
                            AnualFinal.setStyle("-fx-font: 16 arial;");
                            AnualFinal.setLayoutX(50);
                            AnualFinal.setLayoutY(370);
                            root.getChildren().addAll(AnualFinal, MortgageFinal, GraphButton, FileButton);

                        }
                    }
                    else{
                        if(PrincipalField.getText().isEmpty())
                            root.getChildren().add(PrincipalError);
                        else if(!Input.PrincipalValid(PrincipalField))
                            root.getChildren().add(PrincipalValueError);
                        if(PeriodField.getText().isEmpty())
                            root.getChildren().add(PeriodError);
                        else if(!Input.PeriodValid(PeriodField))
                            root.getChildren().add(PeriodValueError);
                        if(InterestRateField.getText().isEmpty())
                            root.getChildren().add(InterestError);
                        else if(!Input.InterestRateValid(InterestRateField))
                            root.getChildren().add(InterestValueError);
                    }
                }
        });

        GraphButton.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent actionEvent) {
                if(Input.activateButton(PrincipalField, InterestRateField, PeriodField, LinijinisButton, AnuitetoButton))
                {
                    LoanData loanData = new LoanData(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton);
                    if(LinijinisButton.isSelected()){
                        loanData.calculateLinear();
                        loanData.setupGraph();
                    }
                    else{
                        loanData.calculateAnnuity();
                        loanData.setupGraph();
                    }
                }
            }
        });

        TableButton.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent actionEvent) {
                LoanData loanData = new LoanData(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton);
                loanData.calculateLinear();
                loanData.setupTable();
            }
        });

        FileButton.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                if (Input.activateButton(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton)) {
                    LoanData loanData = new LoanData(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton);
                    if(loanData.linearChosen()){
                        loanData.calculateLinear();
                        loanData.createFile();
                    } else {
                        loanData.calculateAnnuity();
                        loanData.createFile();
                    }
                }
            }});

        Scene scene = new Scene(root, 600, 400);
        primaryStage.setScene(scene);
        scene.setFill(Color.rgb(5, 100, 100));
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
