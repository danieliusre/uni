package sample;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class LoanData extends Input{

    ArrayList<Double> paymentArray = new ArrayList<Double>();
    ArrayList<Double> loanArray = new ArrayList<Double>();
    ArrayList<Double> percentArray = new ArrayList<Double>();
    ArrayList<Double> remainingArray = new ArrayList<Double>();

    LoanData(TextField PrincipalField, TextField PeriodField, TextField InterestRateField, RadioButton LinijinisButton, RadioButton AnuitetoButton) {
        super(PrincipalField, PeriodField, InterestRateField, LinijinisButton, AnuitetoButton);
    }

    public boolean linearChosen(){
        if(super.linijinisButton)
            return true;
        else
            return false;
    }

    public void calculateLinear(){
        double monthlyLoan = getPrincipal()/getPeriod();
        double monthlyPayment;
        double monthlyPercent = getMonthlyInterestRate();
        double decreasePrincipal = getPrincipal();
        BankEarned = 0;
        TotalPaid = 0;
        for(int i=0; i< getPeriod(); i++){
            monthlyPayment = monthlyPercent * decreasePrincipal;
            decreasePrincipal = decreasePrincipal - monthlyLoan;
            if(decreasePrincipal <= 0)
                decreasePrincipal = 0;
            paymentArray.add(monthlyPayment + monthlyLoan);
            loanArray.add(monthlyLoan);
            percentArray.add(monthlyPayment);
            remainingArray.add(decreasePrincipal);
            super.BankEarned += monthlyPayment;
            super.TotalPaid += monthlyLoan;
            if(decreasePrincipal < 0){
                decreasePrincipal = 0;
                i = getPeriod();
                setPeriod(i);
            }
        }
    }

    public void calculateAnnuity(){
        double monthlyPayment;
        double decreasePrincipal = getPrincipal();
        double monthlyInterest = getMonthlyInterestRate();
        for(int i=0; i<getPeriod(); i++){
            double mortgageUp = Math.pow((1 + monthlyInterest), getPeriod()) * monthlyInterest;
            double mortgageDown = Math.pow((1 + monthlyInterest), getPeriod()) - 1;
            monthlyPayment = getPrincipal() * mortgageUp / mortgageDown;
            paymentArray.add(monthlyPayment);
            percentArray.add(decreasePrincipal * monthlyInterest);
            loanArray.add(monthlyPayment - (decreasePrincipal * monthlyInterest));
            remainingArray.add(decreasePrincipal);
            super.BankEarned += decreasePrincipal * monthlyInterest;
            decreasePrincipal -= (monthlyPayment - (decreasePrincipal * monthlyInterest));
            super.TotalPaid +=monthlyPayment;
        }
    }

    protected void setupTable(){
        ListView<String> list = new ListView<String>();
        ObservableList<String> lines = FXCollections.observableArrayList();
        lines.add("Mokėjimo nr.         Įmoka      " +
                "   Paskolos grąžinimas         Palūkanos      Paskolos Likutis");
        for(int i = 0; i < getPeriod(); ++i) {
            Month month = new Month(i+1, paymentArray.get(i), loanArray.get(i), percentArray.get(i), remainingArray.get(i));
            lines.add(month.write(i));
        }
        list.setItems(lines);
        VBox vbox = new VBox();
        vbox.setSpacing(8);
        vbox.getChildren().addAll(list);
        Stage stage = new Stage();
        Scene scene = new Scene(vbox, 500, 200);
        stage.setTitle("Paskolos grąžinimo lentelė");
        stage.setScene(scene);
        stage.show();
    }

    protected void setupGraph(){
        final NumberAxis xAxis = new NumberAxis();
        final NumberAxis yAxis = new NumberAxis();
        xAxis.setLabel("Mėnesis");
        yAxis.setLabel("Suma (€)");
        xAxis.setAutoRanging(false);
        xAxis.setLowerBound(1);
        xAxis.setUpperBound(getPeriod());
        final LineChart<Number,Number> lineChart =
                new LineChart<Number,Number>(xAxis,yAxis);

        lineChart.setTitle("Paskolos grąžinimo grafikas");
        XYChart.Series paymentSeries = new XYChart.Series();
        XYChart.Series loanSeries = new XYChart.Series();
        XYChart.Series percentSeries = new XYChart.Series();
        paymentSeries.setName("Įmoka");
        loanSeries.setName("Pagr. suma");
        percentSeries.setName("Palūkanos");

        for(int i = 0; i< getPeriod(); ++i){
            paymentSeries.getData().add(new XYChart.Data(i+1, paymentArray.get(i)));
            loanSeries.getData().add(new XYChart.Data(i+1, loanArray.get(i)));
            percentSeries.getData().add(new XYChart.Data(i+1, percentArray.get(i)));
        }
        Stage stage = new Stage();
        lineChart.getData().addAll(paymentSeries, loanSeries, percentSeries);
        stage.setTitle("Paskolos grąžinimo grafikas");
        Scene scene  = new Scene(lineChart,800,600);
        stage.setScene(scene);
        stage.show();
    }

    public void createFile() {
        if(linijinisButton) {
            try {
                String bankEarned = String.format("%.2f", BankEarned);
                String principal = String.format("%.2f", getPrincipal());
                String totalPaid = String.format("%.2f", (getPrincipal()+BankEarned));
                String percent = String.format("%.2f", getAnnualInterestRate());
                File ataskaita = new File("ataskaita.txt");
                ataskaita.delete();
                FileWriter fileWriter = new FileWriter("ataskaita.txt");
                fileWriter.write("PASKOLOS ATASKAITA\n");
                fileWriter.write("Paskolos tipas: Linijinis\n");
                fileWriter.write("Paskolos suma:: " + principal + "\n");
                fileWriter.write("Periodas (mėn): " + getPeriod() + "\n");
                fileWriter.write("Metinis procentas (Interest rate): " + percent + "\n");
                fileWriter.write("Išmoka: (žr. lentelėje)\n");
                fileWriter.write("Bankas uždirbo(€): " + bankEarned + "\n");
                fileWriter.write("Viso sumokėta(€): " + totalPaid + "\n");
                fileWriter.close();
            } catch (IOException exception) {
                System.out.println("An error occurred while trying to create file.");
            }
        }else if(anuitetoButton){
            try {
                String bankEarned = String.format("%.2f", BankEarned);
                String totalPaid = String.format("%.2f", TotalPaid);
                String principal = String.format("%.2f", getPrincipal());
                String percent = String.format("%.2f", getAnnualInterestRate());
                String interest = String.format("%.2f", (getPrincipal() * getMonthlyInterestRate() / (1 - (float)Math.pow((1 + getMonthlyInterestRate()), -1*getPeriod()))) );
                File ataskaita = new File("ataskaita.txt");
                ataskaita.delete();
                FileWriter fileWriter = new FileWriter("ataskaita.txt");
                fileWriter.write("PASKOLOS ATASKAITA\n");
                fileWriter.write("Paskolos tipas: Anuiteto\n");
                fileWriter.write("Paskolos suma: " + principal + "\n");
                fileWriter.write("Periodas (mėn): " + getPeriod() + "\n");
                fileWriter.write("Metinis procentas: " + percent + "\n");
                fileWriter.write("Išmoka: " +  interest + "\n");
                fileWriter.write("Bankas uždirbo(€): " + bankEarned + "\n");
                fileWriter.write("Viso sumokėta(€): " + totalPaid + "\n");
                fileWriter.close();
            } catch (IOException exception) {
                System.out.println("An error occurred while trying to create file.");
            }        }
    }

}
