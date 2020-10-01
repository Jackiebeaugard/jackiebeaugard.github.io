package edu.mccneb;

import java.sql.*;

public class SelectWithParameters {

    /**
     * Connect to the test.db database
     * @return the Connection object
     */
    private Connection connect() {
        // SQLite connection string
        String url = "jdbc:sqlite:C:/mcc/sql-jdbc/chinook.db";
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return conn;
    }
    /**
     * Get the tracks with unit price greater than specified amount.
     * @param unitprice of the track
     */
    public void getUnitPriceGreaterThan(double unitprice) {
        String sql = "SELECT trackid, name, unitprice, composer "
                + "FROM tracks WHERE UnitPrice > ?";

        try (Connection conn = this.connect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // set the value
            pstmt.setDouble(1, unitprice);
            //
            ResultSet rs = pstmt.executeQuery();

            // loop through the result set
            while (rs.next()) {
                System.out.println(rs.getInt("trackid") + "\t" +
                        rs.getString("name") + "\t" +
                        rs.getDouble("unitprice")+ "\t" +
                        rs.getString("composer"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        SelectWithParameters app = new SelectWithParameters();
        app.getUnitPriceGreaterThan(1.50);
    }
}
