package edu.mccneb;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

    /**
     *
     * @author sqlitetutorial.net
     */
    public class SelectWithoutParameters {

        /**
         * Connect to the test.db database
         * @return the Connection object
         */
        private Connection connect() {
            // SQLite connection string
            String url = "jdbc:sqlite:C:/Users/student/Desktop/jackiebeaugard.github.io/sql-jdbc/chinook.db";
            Connection conn = null;
            try {
                conn = DriverManager.getConnection(url);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
            return conn;
        }


        /**
         * select all rows in the warehouses table
         */
        public void selectAll(){
            String sql = "SELECT artistid, name FROM artists";

            try (Connection conn = this.connect();
                 Statement stmt  = conn.createStatement();
                 ResultSet rs    = stmt.executeQuery(sql)){

                // loop through the result set
                while (rs.next()) {
                    System.out.println(rs.getInt("artistid") +  "\t" +
                            rs.getString("name"));
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }


        /**
         * @param args the command line arguments
         */
        public static void main(String[] args) {
            SelectWithoutParameters app = new SelectWithoutParameters();
            app.selectAll();
        }


}
