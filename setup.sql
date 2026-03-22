-- ============================================================
-- India Tourist Guide — Full MySQL Setup Script
-- Run this in MySQL Workbench or terminal before starting app
-- ============================================================

CREATE DATABASE IF NOT EXISTS tourist_guide;
USE tourist_guide;

-- ----------------------------
-- Table: cities
-- ----------------------------
CREATE TABLE IF NOT EXISTS cities (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    theme       VARCHAR(100),
    history     TEXT,
    highlight   VARCHAR(500),
    badge_class VARCHAR(50)
);

-- ----------------------------
-- Table: places
-- ----------------------------
CREATE TABLE IF NOT EXISTS places (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    city_id     INT NOT NULL,
    name        VARCHAR(150) NOT NULL,
    description TEXT,
    entry_fee   DECIMAL(10,2) DEFAULT 0,
    timings     VARCHAR(100),
    FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE
);

-- ----------------------------
-- Table: products (fair prices)
-- ----------------------------
CREATE TABLE IF NOT EXISTS products (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    city_id      INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    fair_price   DECIMAL(10,2) NOT NULL,
    unit         VARCHAR(80),
    notes        VARCHAR(300),
    FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE
);

-- ----------------------------
-- Seed: Cities
-- ----------------------------
INSERT INTO cities (name, theme, history, highlight, badge_class) VALUES

('Jaipur', 'Heritage & Royalty',
 'Founded in 1727 by Maharaja Sawai Jai Singh II, Jaipur is known as the Pink City of Rajasthan. It is one of India\'s first planned cities, designed in a grid pattern with wide boulevards. The city served as the seat of the Kachwaha Rajput kings for centuries, and its rose-pink buildings — originally painted to welcome Prince Albert in 1876 — have remained its defining feature ever since.',
 'Jaipur is a UNESCO World Heritage City (2019) and forms part of the Golden Triangle tourist circuit with Delhi and Agra.',
 'badge-heritage'),

('Goa', 'Beach & Nightlife',
 'A former Portuguese colony for 450 years until 1961, Goa is India\'s smallest state by area but richest in culture and cuisine. The Portuguese left behind a unique blend of Baroque churches, Latin architecture, and a Konkani-Portuguese culinary tradition. Today it draws visitors with its palm-fringed beaches, vibrant nightlife, and relaxed coastal culture.',
 'Old Goa\'s churches are a UNESCO World Heritage Site. The Basilica of Bom Jesus holds the mortal remains of St. Francis Xavier.',
 'badge-beach'),

('Manali', 'Adventure & Mountains',
 'Nestled in the Kullu Valley of Himachal Pradesh at 2,050m above sea level, Manali has been a gateway to Lahaul, Spiti, and Ladakh for centuries. Named after Manu, the Hindu sage believed to have survived a great flood here, the town blends ancient temples with a modern adventure-tourism culture.',
 'Manali is the base for the famous Manali-Leh highway, one of the highest motorable roads in the world at 5,359m.',
 'badge-adventure'),

('Varanasi', 'Spiritual & Cultural',
 'One of the world\'s oldest continuously inhabited cities, Varanasi has been a centre of Hindu spirituality for over 3,000 years. Situated on the western bank of the sacred Ganges, it is believed that dying here brings moksha (liberation from rebirth). The city is also a hub of classical music, silk weaving, and Sanskrit learning.',
 'Varanasi has over 80 ghats along the Ganges. The Ganga Aarti ceremony at Dashashwamedh Ghat every evening is one of India\'s most spectacular rituals.',
 'badge-spiritual'),

('Agra', 'Heritage & Royalty',
 'Home to the Taj Mahal, Agra was the capital of the Mughal Empire during the 16th and 17th centuries. Emperor Shah Jahan built the Taj Mahal between 1631 and 1653 as a mausoleum for his wife Mumtaz Mahal. The city also houses Agra Fort and Fatehpur Sikri, both UNESCO World Heritage Sites.',
 'The Taj Mahal is considered one of the Seven Wonders of the Modern World and receives over 7 million visitors per year.',
 'badge-heritage');

-- ----------------------------
-- Seed: Places (Jaipur = id 1)
-- ----------------------------
INSERT INTO places (city_id, name, description, entry_fee, timings) VALUES
(1, 'Amber Fort', 'A magnificent hilltop fort built in 1592, showcasing stunning Rajput and Mughal architecture. The Sheesh Mahal (Mirror Palace) dazzles with thousands of tiny mirrors.', 100, '8:00 AM – 5:30 PM'),
(1, 'Hawa Mahal', 'The iconic Palace of Winds with 953 small latticed windows, originally designed so royal women could observe street life without being seen.', 50, '9:00 AM – 4:30 PM'),
(1, 'City Palace', 'A sprawling royal complex housing museums with royal collections, textiles, and weapons. The Maharaja still resides in part of it.', 200, '9:30 AM – 5:00 PM'),
(1, 'Jantar Mantar', 'The world\'s largest stone sundial and UNESCO-listed astronomical observatory built by Maharaja Jai Singh II in 1734.', 50, '9:00 AM – 4:30 PM');

-- Places (Goa = id 2)
INSERT INTO places (city_id, name, description, entry_fee, timings) VALUES
(2, 'Basilica of Bom Jesus', 'Built in 1605, this UNESCO World Heritage church is one of the finest examples of Baroque architecture in India. It houses the mortal remains of St. Francis Xavier.', 0, '9:00 AM – 6:30 PM'),
(2, 'Calangute Beach', 'The largest and most popular beach in North Goa, known as the Queen of Beaches. Busy with water sports, shacks, and a lively atmosphere.', 0, 'All day'),
(2, 'Fort Aguada', 'A 17th-century Portuguese fort offering panoramic ocean views at the confluence of the Mandovi River and Arabian Sea.', 30, '9:30 AM – 6:00 PM');

-- Places (Manali = id 3)
INSERT INTO places (city_id, name, description, entry_fee, timings) VALUES
(3, 'Rohtang Pass', 'At 3,978m, this high mountain pass offers snow year-round and panoramic views of Lahaul Valley. Open May to November.', 500, '6:00 AM – 2:00 PM'),
(3, 'Hadimba Devi Temple', 'A 16th-century wooden temple dedicated to Hadimba Devi, set within a cedar forest. The pagoda-style structure is a masterpiece of Himalayan architecture.', 0, '8:00 AM – 6:00 PM'),
(3, 'Solang Valley', 'A scenic valley famous for skiing, zorbing, paragliding, and cable car rides with stunning Himalayan backdrops.', 100, '9:00 AM – 5:00 PM');

-- Places (Varanasi = id 4)
INSERT INTO places (city_id, name, description, entry_fee, timings) VALUES
(4, 'Kashi Vishwanath Temple', 'The holiest of all Shiva temples. The current golden spire was donated by Maharaja Ranjit Singh in the 19th century.', 0, '3:00 AM – 11:00 PM'),
(4, 'Dashashwamedh Ghat', 'The main ghat on the Ganges where the spectacular Ganga Aarti with fire, incense, and chanting is performed every evening.', 0, 'All day; Aarti at 7:00 PM'),
(4, 'Sarnath', 'Located 10km from Varanasi, this is where Gautama Buddha gave his first sermon. The Dhamek Stupa dates to 500 CE.', 40, 'Sunrise – Sunset');

-- Places (Agra = id 5)
INSERT INTO places (city_id, name, description, entry_fee, timings) VALUES
(5, 'Taj Mahal', 'The white marble mausoleum built by Emperor Shah Jahan for his wife Mumtaz Mahal between 1631–1653. A UNESCO World Heritage Site.', 1100, 'Sunrise – Sunset (closed Friday)'),
(5, 'Agra Fort', 'A massive red sandstone Mughal fort that served as the main residence of the emperors of the Mughal Dynasty. Also a UNESCO Site.', 550, '6:00 AM – 6:00 PM'),
(5, 'Mehtab Bagh', 'A moonlit garden directly across the Yamuna River from the Taj Mahal, offering a stunning sunset reflection view.', 300, '6:00 AM – 6:00 PM');

-- ----------------------------
-- Seed: Products (Jaipur)
-- ----------------------------
INSERT INTO products (city_id, product_name, fair_price, unit, notes) VALUES
(1, 'Blue Pottery',       350, 'per piece',   'Original Jaipur blue pottery — beware of painted fakes sold as authentic'),
(1, 'Bandhani Saree',     800, 'per piece',   'Authentic tie-dye fabric; polyester copies sold at same price'),
(1, 'Rajasthani Spices',  120, 'per 100g',    'Local spice mixes; fixed rate at Johari Bazaar'),
(1, 'Mojari Footwear',    400, 'per pair',    'Hand-embroidered leather shoes; haggling is expected');

-- Products (Goa)
INSERT INTO products (city_id, product_name, fair_price, unit, notes) VALUES
(2, 'Cashew Nuts (local)', 400, 'per 500g',     'Premium Goan cashews; airport shops charge double'),
(2, 'Feni (Cashew liquor)',220, 'per 750ml',    'Authentic local spirit; avoid tourist-trap brands'),
(2, 'Goan Spice Packets',   80, 'per pack',     'Masala mixes; beach stalls often overcharge by 3x'),
(2, 'Beach Sarong',         150, 'per piece',   'Often sold for ₹400+ near beaches; always negotiate');

-- Products (Manali)
INSERT INTO products (city_id, product_name, fair_price, unit, notes) VALUES
(3, 'Himachali Wool Shawl', 1200, 'per piece',  'Genuine Kullu wool; synthetic look-alikes sold for same price'),
(3, 'Dried Apricots',        300, 'per 500g',   'Local dried fruit; tourist shops charge 60% extra'),
(3, 'Apple Jam',             120, 'per jar',    'Homemade vs. commercial — ask to see ingredients'),
(3, 'Bamboo Trekking Stick', 100, 'per piece',  'Also available on rental at ₹30/day from local shops');

-- Products (Varanasi)
INSERT INTO products (city_id, product_name, fair_price, unit, notes) VALUES
(4, 'Banarasi Silk Saree',  3500, 'pure silk',  'Verify handloom tag; power-loom fakes are common'),
(4, 'Thandai Mix',           150, 'per 200g',   'Traditional festive drink mix; tourists often overcharged'),
(4, 'Rudraksha Mala',        200, 'per mala',   'Single-face rudraksha much rarer and pricier; verify'),
(4, 'Ganga Boat Ride',       200, 'per person', 'Fixed price for sunrise ride; full boat ₹600–800');

-- Products (Agra)
INSERT INTO products (city_id, product_name, fair_price, unit, notes) VALUES
(5, 'Marble Inlay Work',    800, 'per piece',   'Handcrafted pietra dura; plastic fakes sold near Taj gates'),
(5, 'Petha Sweet',           80, 'per 250g',   'Agra\'s famous pumpkin sweet; original vs. cheap copies'),
(5, 'Leather Goods',        350, 'per item',    'Agra leather; check stitching quality before buying');

SELECT 'Setup complete! Tourist Guide DB is ready.' AS status;
