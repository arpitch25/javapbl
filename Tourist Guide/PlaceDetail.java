package model;

import java.util.List;

/**
 * PlaceDetail JavaBean - extended place info including
 * photos, activities and popular things.
 */
public class PlaceDetail {
    private int    id;
    private int    cityId;
    private String name;
    private String description;
    private double entryFee;
    private String timings;
    private String rating;
    private String duration;
    private String emoji;
    private String bgColor;

    // One-to-many collections
    private List<String>   photos;
    private List<Activity> activities;
    private List<String>   popularThings;

    public PlaceDetail() {}

    // --- Getters ---
    public int          getId()            { return id; }
    public int          getCityId()        { return cityId; }
    public String       getName()          { return name; }
    public String       getDescription()   { return description; }
    public double       getEntryFee()      { return entryFee; }
    public String       getTimings()       { return timings; }
    public String       getRating()        { return rating; }
    public String       getDuration()      { return duration; }
    public String       getEmoji()         { return emoji; }
    public String       getBgColor()       { return bgColor; }
    public List<String>   getPhotos()      { return photos; }
    public List<Activity> getActivities()  { return activities; }
    public List<String>   getPopularThings(){ return popularThings; }

    // --- Setters ---
    public void setId(int id)                          { this.id = id; }
    public void setCityId(int cityId)                  { this.cityId = cityId; }
    public void setName(String name)                   { this.name = name; }
    public void setDescription(String description)     { this.description = description; }
    public void setEntryFee(double entryFee)           { this.entryFee = entryFee; }
    public void setTimings(String timings)             { this.timings = timings; }
    public void setRating(String rating)               { this.rating = rating; }
    public void setDuration(String duration)           { this.duration = duration; }
    public void setEmoji(String emoji)                 { this.emoji = emoji; }
    public void setBgColor(String bgColor)             { this.bgColor = bgColor; }
    public void setPhotos(List<String> photos)         { this.photos = photos; }
    public void setActivities(List<Activity> a)        { this.activities = a; }
    public void setPopularThings(List<String> p)       { this.popularThings = p; }

    public String getFormattedFee() {
        return (entryFee == 0) ? "Free" : "₹" + (int) entryFee;
    }

    // --- Inner class: Activity ---
    public static class Activity {
        private String icon;
        private String name;
        private String description;

        public Activity() {}
        public Activity(String icon, String name, String description) {
            this.icon = icon; this.name = name; this.description = description;
        }

        public String getIcon()        { return icon; }
        public String getName()        { return name; }
        public String getDescription() { return description; }
        public void setIcon(String i)  { this.icon = i; }
        public void setName(String n)  { this.name = n; }
        public void setDescription(String d) { this.description = d; }
    }
}
