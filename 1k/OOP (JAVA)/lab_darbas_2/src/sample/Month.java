package sample;

public class Month {
    private final String n;
    private final String payment;
    private final String loan;
    private final String interest;
    private final String remaining;

    Month(int n, double payment, double loan, double interest, double remaining){
        this.n = Integer.toString(n);
        this.payment = String.format("%10.2f", payment);
        this.loan = String.format("%10.2f", loan);
        this.interest = String.format("%10.2f", interest);
        this.remaining = String.format("%20.2f", remaining);
    }
    public String write (int i){
        String nl = String.format("%20s.%15s          %15s              %15s" +
                "       %15s", n, payment, loan, interest, remaining);
        return nl;
    }
}
