package model;

/**
 * City JavaBean - represents a tourist city.
 * Follows JavaBean convention (private fields + public getters/setters).
 */
public class City {
    private int    id;
    private String name;
    private String theme;
    private String history;
    private String highlight;
    private String badgeClass; // CSS class for theme badge colour

    public City() {}

    public City(int id, String name, String theme, String history, String highlight, String badgeClass) {
        this.id         = id;
        this.name       = name;
        this.theme      = theme;
        this.history    = history;
        this.highlight  = highlight; 
        this.badgeClass = badgeClass;
    }

    public int    getId()         { return id; }
    public String getName()       { return name; }
    public String getTheme()      { return theme; }
    public String getHistory()    { return history; }
    public String getHighlight()  { return highlight; }
    public String getBadgeClass() { return badgeClass; }

    public void setId(int id)                 { this.id = id; }
    public void setName(String name)          { this.name = name; }
    public void setTheme(String theme)        { this.theme = theme; }
    public void setHistory(String history)    { this.history = history; }
    public void setHighlight(String h)        { this.highlight = h; }
    public void setBadgeClass(String b)       { this.badgeClass = b; }

    @Override
    public String toString() {
        return name + " — " + theme;
    }
}
