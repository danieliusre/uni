package sample;

import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import org.w3c.dom.Text;

public class Input {
    private static double principal;
    private static double annualInterestRate;
    private static int period;
    protected static boolean linijinisButton;
    protected static boolean anuitetoButton;
    protected float BankEarned;
    protected float TotalPaid;

    Input(TextField PrincipalField, TextField PeriodField, TextField InterestRateField, RadioButton linijinisButton, RadioButton anuitetoButton){
        if(!PrincipalField.getText().isEmpty() && !InterestRateField.getText().isEmpty() && !PeriodField.getText().isEmpty() && linijinisButton.isSelected()){
            this.principal = Double.parseDouble(PrincipalField.getText());
            this.annualInterestRate = Double.parseDouble(InterestRateField.getText());
            this.period = (int) Double.parseDouble(PeriodField.getText());
            this.linijinisButton = linijinisButton.isSelected();
            this.anuitetoButton = anuitetoButton.isSelected();
        }
        else if (!PrincipalField.getText().isEmpty() && !InterestRateField.getText().isEmpty() && !PeriodField.getText().isEmpty() && anuitetoButton.isSelected()) {
            this.principal = Float.parseFloat(PrincipalField.getText());
            this.annualInterestRate = Float.parseFloat(InterestRateField.getText());
            this.period = (int) Double.parseDouble(PeriodField.getText());
            this.linijinisButton = linijinisButton.isSelected();
            this.anuitetoButton = anuitetoButton.isSelected();
        }
    }
    public static boolean PrincipalValid(TextField PrincipalField) {
        double temp = Double.parseDouble(PrincipalField.getText());
        if( temp < 1_000 || temp > 10_000_000 )
            return false;
        else
            return true;
    }
    public static boolean PeriodValid(TextField PeriodField) {
        double temp = Double.parseDouble(PeriodField.getText());
        if( temp <= 0 || temp > 400 )
            return false;
        else
            return true;
    }
    public static boolean InterestRateValid(TextField InterestRateField) {
        double temp = Double.parseDouble(InterestRateField.getText());
        if( temp <= 0 || temp > 10 )
            return false;
        else
            return true;
    }

    public static boolean allValid(TextField PrincipalField, TextField PeriodField, TextField InterestRateField){
        if(PrincipalValid(PrincipalField) && PeriodValid(PeriodField) && InterestRateValid(InterestRateField))
            return true;
        else
            return false;
    }

    public static void setPeriod(int period){ Input.period = period; }

    public double getPrincipal(){ return principal; }

    public double getAnnualInterestRate(){ return annualInterestRate; }

    public double getMonthlyInterestRate(){ return annualInterestRate / (12 * 100 ); }

    public int getPeriod(){ return period; }

    public static boolean activateButton(TextField principal, TextField period, TextField annualInterestRate, RadioButton linijinisButton, RadioButton anuitetoButton){
        if(!principal.getText().isEmpty() && !annualInterestRate.getText().isEmpty() && !period.getText().isEmpty() && (linijinisButton.isSelected() || anuitetoButton.isSelected())){
            return true;
        }
        else
            return false;
    }
}
