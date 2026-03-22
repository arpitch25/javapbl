package model;

/**
 * Product JavaBean - represents a product with fair market price
 * to help tourists avoid being overcharged.
 */
public class Product {
    private int    id;
    private int    cityId;
    private String productName;
    private double fairPrice;
    private String unit;
    private String notes;

    public Product() {}

    public Product(int id, int cityId, String productName, double fairPrice, String unit, String notes) {
        this.id          = id;
        this.cityId      = cityId;
        this.productName = productName;
        this.fairPrice   = fairPrice;
        this.unit        = unit;
        this.notes       = notes;
    }

    public int    getId()          { return id; }
    public int    getCityId()      { return cityId; }
    public String getProductName() { return productName; }
    public double getFairPrice()   { return fairPrice; }
    public String getUnit()        { return unit; }
    public String getNotes()       { return notes; }

    public void setId(int id)                    { this.id = id; }
    public void setCityId(int cityId)            { this.cityId = cityId; }
    public void setProductName(String n)         { this.productName = n; }
    public void setFairPrice(double p)           { this.fairPrice = p; }
    public void setUnit(String unit)             { this.unit = unit; }
    public void setNotes(String notes)           { this.notes = notes; }

    public String getFormattedPrice() {
        return "₹" + (int) fairPrice + " " + unit;
    }
}
