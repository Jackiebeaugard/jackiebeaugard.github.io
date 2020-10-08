package edu.mccneb;

import java.sql.*;

public class GenerateSQLReport {
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

    public void selectTrackAlbumsArtists(){
        String sql = "SELECT tracks.TrackId AS TrackId, tracks.Name AS TracksName, albums.Title AS AlbumsTitle, artists.Name AS ArtistsName FROM tracks " +
                "INNER JOIN albums ON albums.AlbumId = tracks.AlbumId " +
                "INNER JOIN artists ON artists.ArtistId = albums.ArtistId";
        try (Connection conn = this.connect();
             Statement stmt  = conn.createStatement();
             ResultSet rs    = stmt.executeQuery(sql)){
            // loop through the result set
            while (rs.next()) {
                System.out.println(rs.getInt("TrackId") +  "\t" +
                        rs.getString("TracksName") +  "\t" +
                        rs.getString("AlbumsTitle") +  "\t" +
                        rs.getString("ArtistsName")
                );
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    /**
     * @param args the command line arguments
     */

    public static void main(String[] args) {
        GenerateSQLReport app = new GenerateSQLReport();
        app.selectTrackAlbumsArtists();
    }
}
