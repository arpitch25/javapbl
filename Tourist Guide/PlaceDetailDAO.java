package dao;

import db.DBConnection;
import model.PlaceDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * PlaceDetailDAO — fetches extended place info:
 * photos, activities, and popular things via JDBC.
 *
 * Requires three extra tables:
 *   place_photos, place_activities, place_popular
 */
public class PlaceDetailDAO {

    /** Fetch full place detail by place ID. */
    public PlaceDetail getPlaceDetail(int placeId) throws SQLException {
        PlaceDetail detail = null;

        // 1. Core place info
        String sqlPlace =
            "SELECT p.id, p.city_id, p.name, p.description, p.entry_fee, p.timings, " +
            "       pd.rating, pd.duration, pd.emoji, pd.bg_color " +
            "FROM places p " +
            "LEFT JOIN place_meta pd ON p.id = pd.place_id " +
            "WHERE p.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sqlPlace)) {

            ps.setInt(1, placeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new PlaceDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setCityId(rs.getInt("city_id"));
                    detail.setName(rs.getString("name"));
                    detail.setDescription(rs.getString("description"));
                    detail.setEntryFee(rs.getDouble("entry_fee"));
                    detail.setTimings(rs.getString("timings"));
                    detail.setRating(rs.getString("rating") != null ? rs.getString("rating") : "4.5");
                    detail.setDuration(rs.getString("duration") != null ? rs.getString("duration") : "1–2 hrs");
                    detail.setEmoji(rs.getString("emoji") != null ? rs.getString("emoji") : "📍");
                    detail.setBgColor(rs.getString("bg_color") != null ? rs.getString("bg_color") : "#E1F5EE");
                }
            }
        }

        if (detail == null) return null;

        // 2. Photos
        detail.setPhotos(getPhotos(placeId));

        // 3. Activities
        detail.setActivities(getActivities(placeId));

        // 4. Popular things
        detail.setPopularThings(getPopularThings(placeId));

        return detail;
    }

    /** Fetch photo emojis for a place. */
    private List<String> getPhotos(int placeId) throws SQLException {
        List<String> photos = new ArrayList<>();
        String sql = "SELECT photo_emoji FROM place_photos WHERE place_id = ? ORDER BY sort_order";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, placeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) photos.add(rs.getString("photo_emoji"));
            }
        }
        return photos;
    }

    /** Fetch activities for a place. */
    private List<PlaceDetail.Activity> getActivities(int placeId) throws SQLException {
        List<PlaceDetail.Activity> list = new ArrayList<>();
        String sql = "SELECT icon, name, description FROM place_activities WHERE place_id = ? ORDER BY sort_order";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, placeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PlaceDetail.Activity(
                        rs.getString("icon"),
                        rs.getString("name"),
                        rs.getString("description")
                    ));
                }
            }
        }
        return list;
    }

    /** Fetch popular things for a place. */
    private List<String> getPopularThings(int placeId) throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT thing_name FROM place_popular WHERE place_id = ? ORDER BY sort_order";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, placeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(rs.getString("thing_name"));
            }
        }
        return list;
    }

    /** Get all place IDs for a city (for sidebar navigation). */
    public List<Integer> getPlaceIdsByCity(int cityId) throws SQLException {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT id FROM places WHERE city_id = ? ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cityId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) ids.add(rs.getInt("id"));
            }
        }
        return ids;
    }
}
