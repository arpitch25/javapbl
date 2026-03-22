package model;

/**
 * Place JavaBean - represents a tourist place within a city.
 */
public class Place {
    private int    id;
    private int    cityId;
    private String name;
    private String description;
    private double entryFee;
    private String timings;

    public Place() {}

    public Place(int id, int cityId, String name, String description, double entryFee, String timings) {
        this.id          = id;
        this.cityId      = cityId;
        this.name        = name;
        this.description = description;
        this.entryFee    = entryFee;
        this.timings     = timings;
    }

    public int    getId()          { return id; }
    public int    getCityId()      { return cityId; }
    public String getName()        { return name; }
    public String getDescription() { return description; }
    public double getEntryFee()    { return entryFee; }
    public String getTimings()     { return timings; }

    public void setId(int id)                    { this.id = id; }
    public void setCityId(int cityId)            { this.cityId = cityId; }
    public void setName(String name)             { this.name = name; }
    public void setDescription(String d)         { this.description = d; }
    public void setEntryFee(double entryFee)     { this.entryFee = entryFee; }
    public void setTimings(String timings)       { this.timings = timings; }

    /** Returns "Free" if fee is 0, else "₹XX" */
    public String getFormattedFee() {
        return (entryFee == 0) ? "Free" : "₹" + (int) entryFee;
    }
}
