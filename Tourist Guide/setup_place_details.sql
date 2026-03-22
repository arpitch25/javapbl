-- ============================================================
-- Place Detail Tables — run AFTER setup.sql
-- Adds: place_meta, place_photos, place_activities, place_popular
-- ============================================================

USE tourist_guide;

-- ----------------------------
-- place_meta: extra info per place
-- ----------------------------
CREATE TABLE IF NOT EXISTS place_meta (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    place_id   INT NOT NULL UNIQUE,
    rating     VARCHAR(10) DEFAULT '4.5',
    duration   VARCHAR(50) DEFAULT '1-2 hrs',
    emoji      VARCHAR(10) DEFAULT '📍',
    bg_color   VARCHAR(20) DEFAULT '#E1F5EE',
    FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE
);

-- ----------------------------
-- place_photos: emoji-based photo gallery
-- ----------------------------
CREATE TABLE IF NOT EXISTS place_photos (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    place_id    INT NOT NULL,
    photo_emoji VARCHAR(10) NOT NULL,
    sort_order  INT DEFAULT 0,
    FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE
);

-- ----------------------------
-- place_activities: things to do
-- ----------------------------
CREATE TABLE IF NOT EXISTS place_activities (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    place_id    INT NOT NULL,
    icon        VARCHAR(10),
    name        VARCHAR(100),
    description VARCHAR(300),
    sort_order  INT DEFAULT 0,
    FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE
);

-- ----------------------------
-- place_popular: popular things/spots
-- ----------------------------
CREATE TABLE IF NOT EXISTS place_popular (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    place_id    INT NOT NULL,
    thing_name  VARCHAR(150),
    sort_order  INT DEFAULT 0,
    FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE
);

-- ============================================================
-- SEED DATA — assumes place IDs 1–15 from setup.sql
-- Jaipur: 1=Amber Fort, 2=Hawa Mahal, 3=City Palace, 4=Jantar Mantar
-- Goa:    5=Basilica, 6=Calangute, 7=Fort Aguada
-- Manali: 8=Rohtang, 9=Hadimba, 10=Solang
-- Varanasi: 11=Kashi Vishwanath, 12=Dashashwamedh, 13=Sarnath
-- Agra:   14=Taj Mahal, 15=Agra Fort, 16=Mehtab Bagh
-- ============================================================

-- ============================================================
-- JAIPUR PLACES
-- ============================================================

-- 1. Amber Fort
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (1,'4.7','2-3 hrs','🏯','#EEEDFE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (1,'🏯',1),(1,'🪞',2),(1,'🐘',3),(1,'🏔️',4),(1,'🌅',5),(1,'🎨',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(1,'🐘','Elephant Ride','Traditional decorated elephant ride up to the fort entrance — a classic Amber Fort experience.',1),
(1,'🪞','Sheesh Mahal Tour','Guided tour of the Palace of Mirrors — a thousand tiny reflections light up from a single candle.',2),
(1,'🔭','Sound & Light Show','Evening show narrating fort history with dramatic lighting on the stone walls.',3),
(1,'📸','Photography Walk','Capture panoramic views of Maota Lake and the Jaipur cityscape far below.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(1,'Sheesh Mahal (Mirror Palace)',1),(1,'Diwan-e-Aam (Hall of Public Audience)',2),
(1,'Ganesh Pol Gateway',3),(1,'Maota Lake viewpoint',4),(1,'Sukh Niwas (Hall of Pleasure)',5),(1,'Jas Mandir',6);

-- 2. Hawa Mahal
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (2,'4.6','1 hr','🏛️','#FAEEDA');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (2,'🏛️',1),(2,'🪟',2),(2,'🌆',3),(2,'🌄',4),(2,'📿',5),(2,'🎴',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(2,'📸','Facade Photography','Best shot from the street opposite — iconic pink honeycomb facade at golden hour.',1),
(2,'🏛️','Museum Visit','Small archaeological museum inside displaying artefacts and paintings from Jaipur history.',2),
(2,'🌇','Sunset View','Watch the golden sun set over Jaipur\'s pink rooftops from the upper-floor windows.',3),
(2,'🛍️','Bazaar Stroll','Explore Johari Bazaar right below — the finest jewellery and textile market in Jaipur.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(2,'953-window latticed facade',1),(2,'Octagonal chambers',2),(2,'Archaeological museum inside',3),
(2,'View of Jantar Mantar',4),(2,'Johari Bazaar below',5),(2,'Rooftop city panorama',6);

-- 3. City Palace
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (3,'4.7','2-3 hrs','👑','#E6F1FB');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (3,'👑',1),(3,'🏛️',2),(3,'🎨',3),(3,'🗡️',4),(3,'🌺',5),(3,'🪔',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(3,'🗡️','Weapons Museum','Study royal swords, shields and guns from the Mughal and Rajput era.',1),
(3,'🎨','Textile Gallery','Browse royal fabrics, garments and miniature paintings from past Maharajas.',2),
(3,'📸','Courtyard Photography','The peacock gates and central courtyard are stunning photography spots.',3),
(3,'🏛️','Mubarak Mahal Tour','Explore the Welcome Palace built to receive foreign guests of the royal family.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(3,'Peacock Gate (Mor Chowk)',1),(3,'Mubarak Mahal',2),(3,'Diwan-i-Khas',3),
(3,'Chandra Mahal (still royal residence)',4),(3,'Royal Textile Museum',5),(3,'Weapons and Armoury gallery',6);

-- 4. Jantar Mantar
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (4,'4.5','1-2 hrs','🔭','#E1F5EE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (4,'🔭',1),(4,'⭐',2),(4,'🌙',3),(4,'🏗️',4),(4,'📐',5),(4,'🌞',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(4,'🔭','Astronomy Tour','Learn how 19 giant stone instruments tracked stars and told time with precision.',1),
(4,'🌞','Sundial Reading','The Samrat Yantra reads time to an accuracy of 2 seconds — try reading it yourself.',2),
(4,'📚','Guided Lecture','Guides explain Mughal-era astronomy and the mathematics behind each instrument.',3),
(4,'📸','Geometric Photography','Striking abstract architectural shapes make this a favourite for art photography.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(4,'Samrat Yantra (world\'s largest sundial)',1),(4,'Jai Prakash Yantra',2),(4,'Ram Yantra',3),
(4,'Misra Yantra',4),(4,'Rashivalayas (12 zodiac instruments)',5),(4,'Chakra Yantra',6);

-- ============================================================
-- GOA PLACES
-- ============================================================

-- 5. Basilica of Bom Jesus
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (5,'4.8','1 hr','⛪','#E6F1FB');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (5,'⛪',1),(5,'🕊️',2),(5,'🎨',3),(5,'🏛️',4),(5,'🕯️',5),(5,'🌿',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(5,'🙏','Mass Attendance','Attend the daily Latin-rite Mass inside the 400-year-old basilica.',1),
(5,'🎨','Baroque Art Tour','Study the intricate Baroque carvings and gilded altar details with a guide.',2),
(5,'📖','Xavier Shrine Visit','View the silver casket containing the mortal remains of St. Francis Xavier.',3),
(5,'📸','Heritage Walk','Join a guided Old Goa heritage walk covering 5 historic churches nearby.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(5,'Tomb of St. Francis Xavier',1),(5,'Gilded baroque altar',2),(5,'Sacred Heart Chapel',3),
(5,'Church of St. Cajetan nearby',4),(5,'Archaeological Museum Goa',5),(5,'Old Goa Heritage Walk',6);

-- 6. Calangute Beach
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (6,'4.3','Half day','🌊','#E1F5EE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (6,'🌊',1),(6,'🏄',2),(6,'🚤',3),(6,'🐚',4),(6,'🌅',5),(6,'🦀',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(6,'🏄','Surfing & Bodyboarding','Rent boards and take lessons from beach vendors — best at high tide.',1),
(6,'🚤','Banana Boat Ride','Thrilling group ride on an inflatable banana pulled by a speedboat.',2),
(6,'🪂','Parasailing','Soar above the Arabian Sea with certified operators right on the beach.',3),
(6,'🐟','Seafood at Shacks','Fresh catch daily — grilled kingfish, prawns and Goan curry at beach shacks.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(6,'Banana boat rides',1),(6,'Parasailing over the sea',2),(6,'Beach shack seafood',3),
(6,'Sand art festival (Dec)',4),(6,'Jet skiing',5),(6,'Sunset at Baga end',6);

-- 7. Fort Aguada
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (7,'4.4','1-2 hrs','🏰','#FAECE7');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (7,'🏰',1),(7,'🌊',2),(7,'🔭',3),(7,'⚓',4),(7,'🌅',5),(7,'🗺️',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(7,'🔭','Lighthouse Visit','Climb the 19th-century lighthouse for a 360° view of the Goan coastline.',1),
(7,'🚶','Fort Wall Walk','Walk the original Portuguese ramparts that once stretched 79km of coastline.',2),
(7,'📸','Sunset Photography','Best sunset spot in North Goa — fort silhouette glowing over the sea.',3),
(7,'⚓','Heritage Tour','Learn how the fort stored 79 cannons to guard against Dutch naval attacks.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(7,'Old lighthouse (1864)',1),(7,'Portuguese cannons display',2),(7,'Mandovi River confluence',3),
(7,'Sinquerim Beach below',4),(7,'Secret tunnel stories',5),(7,'Sunset panoramic viewpoint',6);

-- ============================================================
-- MANALI PLACES
-- ============================================================

-- 8. Rohtang Pass
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (8,'4.6','Full day','🗻','#EAF3DE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (8,'🗻',1),(8,'❄️',2),(8,'🏔️',3),(8,'🛷',4),(8,'🌨️',5),(8,'🦅',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(8,'🛷','Snow Sledging','Ride wooden sleds down snowy slopes — equipment rented on site at fixed rates.',1),
(8,'🏔️','Snow Scooter','Ride motorised snow scooters across the glacial snowfield at 3,978m.',2),
(8,'📸','Glacier Photography','Capture the Beas Kund glacier and Himalayan peaks at sunrise from the pass.',3),
(8,'🎿','Skiing (winter)','Beginners and advanced slopes available November to February.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(8,'Snow sledging at the pass',1),(8,'Beas Kund glacier',2),(8,'Panoramic Himalayan view',3),
(8,'Snow scooter rides',4),(8,'Bollywood filming location',5),(8,'Lahaul Valley entry gate',6);

-- 9. Hadimba Devi Temple
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (9,'4.5','1 hr','🛕','#FAEEDA');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (9,'🛕',1),(9,'🌲',2),(9,'🦌',3),(9,'🪵',4),(9,'🌿',5),(9,'🌸',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(9,'🙏','Temple Darshan','Seek blessings at the ancient rock idol of Hadimba Devi inside the pagoda.',1),
(9,'🦌','Yak Photography','Pose with traditionally adorned yaks and Angora rabbits right outside the temple.',2),
(9,'🌲','Cedar Forest Walk','Stroll through the ancient Dhungiri cedar forest that surrounds the temple.',3),
(9,'🎭','Dussehra Festival','Attend the famous Kullu Dussehra held in October — listed by UNESCO.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(9,'Rock idol of Hadimba Devi',1),(9,'Intricately carved pagoda doors',2),(9,'Dhungiri cedar forest walk',3),
(9,'Yak and Angora rabbit photo ops',4),(9,'Nearby Manu Temple',5),(9,'Local Himachali food stalls',6);

-- 10. Solang Valley
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (10,'4.4','Half day','🎿','#E1F5EE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (10,'🎿',1),(10,'🪂',2),(10,'🚡',3),(10,'⛷️',4),(10,'🏕️',5),(10,'🌄',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(10,'🪂','Paragliding','Tandem paragliding flights with certified pilots — 15 min soaring over the valley.',1),
(10,'🚡','Gondola Cable Car','Ride the ropeway up to 2,480m for panoramic Himalayan views above the treeline.',2),
(10,'⚽','Zorbing','Roll inside a giant transparent ball down a snow-covered slope.',3),
(10,'🏕️','Mountain Camping','Overnight camps with bonfire and stargazing under crystal clear mountain skies.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(10,'Paragliding takeoff point',1),(10,'Gondola ropeway ride',2),(10,'Winter ski slopes',3),
(10,'Snow zorbing',4),(10,'Mountain overnight camping',5),(10,'Beas River viewpoint',6);

-- ============================================================
-- VARANASI PLACES
-- ============================================================

-- 11. Kashi Vishwanath
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (11,'4.8','1-2 hrs','🛕','#FAEEDA');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (11,'🛕',1),(11,'🪔',2),(11,'🌺',3),(11,'🔔',4),(11,'🙏',5),(11,'✨',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(11,'🙏','Morning Mangala Aarti','Attend the 3 AM Mangala Aarti — considered the most sacred ritual of the day.',1),
(11,'🌺','Flower Offering','Offer marigold garlands and bilva leaves at the sacred Jyotirlinga.',2),
(11,'🔔','Evening Shringar Aarti','The 7 PM aarti fills the air with incense, lamps and Sanskrit chants.',3),
(11,'🗺️','Kashi Corridor Walk','Explore the new Vishwanath Dham corridor connecting the temple to the ghats.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(11,'Main Jyotirlinga Shivling',1),(11,'Golden spire (donated 1839)',2),(11,'Gyan Vapi well',3),
(11,'Vishwanath Dham corridor',4),(11,'Annapurna Devi temple nearby',5),(11,'Kashi Labh Mukti Bhavan',6);

-- 12. Dashashwamedh Ghat
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (12,'4.9','2 hrs (evening)','🪔','#FAECE7');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (12,'🪔',1),(12,'🌊',2),(12,'🛶',3),(12,'🌙',4),(12,'🔥',5),(12,'🌸',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(12,'🛶','Sunrise Boat Ride','Row across the Ganges at sunrise — watch the ghats slowly wake up. ₹200/person.',1),
(12,'🪔','Ganga Aarti Ceremony','Witness the nightly 7 PM ceremony with 11 priests wielding fire lamps.',2),
(12,'🌅','Sunrise at the Ghats','Watch the golden sunrise as pilgrims bathe in the river — the most peaceful moment.',3),
(12,'🏺','Diya and Pottery Stalls','Browse terracotta diyas and Varanasi handicrafts from ghat-side vendors.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(12,'Nightly Ganga Aarti (7 PM)',1),(12,'Sunrise boat ride',2),(12,'Burning Manikarnika Ghat nearby',3),
(12,'Flower offerings in the river',4),(12,'Holy dip in sacred Ganges',5),(12,'Chai at ghat-side stalls',6);

-- 13. Sarnath
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (13,'4.6','2-3 hrs','☸️','#E1F5EE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (13,'☸️',1),(13,'🦌',2),(13,'🏛️',3),(13,'🌿',4),(13,'🔔',5),(13,'🧘',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(13,'🧘','Meditation in Deer Park','Meditate in the exact park where the Buddha taught his first five disciples.',1),
(13,'🏛️','Dhamek Stupa Tour','Explore the 5th-century cylindrical stupa marking the exact first sermon site.',2),
(13,'🦌','Deer Park Walk','Walk through the peaceful grounds where deer still roam freely today.',3),
(13,'🖼️','Sarnath Museum','See the famous Lion Capital of Ashoka — India\'s national emblem — up close.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(13,'Dhamek Stupa (500 CE)',1),(13,'Ashoka Pillar remnants',2),(13,'Lion Capital in Sarnath Museum',3),
(13,'Mulagandha Kuti Vihara',4),(13,'Peaceful deer park grounds',5),(13,'Tibetan and Japanese temples nearby',6);

-- ============================================================
-- AGRA PLACES
-- ============================================================

-- 14. Taj Mahal
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (14,'4.9','2-3 hrs','🕌','#EEEDFE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (14,'🕌',1),(14,'🌅',2),(14,'💎',3),(14,'🌸',4),(14,'🌙',5),(14,'🪞',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(14,'🌅','Sunrise Visit','The most magical time — white marble glows golden pink as the sun rises.',1),
(14,'🌙','Full Moon Night','Special night viewing on 5 nights around each full moon — book well in advance.',2),
(14,'📸','Reflection Pool Shot','The iconic photo at the central hauz pool — the dome reflected perfectly.',3),
(14,'🔍','Pietra Dura Tour','Study the intricate semi-precious stone inlay work up close with an expert guide.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(14,'Main mausoleum dome',1),(14,'Reflection pool',2),(14,'Pietra dura stone inlay',3),
(14,'Main gateway (Darwaza-i-Rauza)',4),(14,'Mosque and Mehman Khana',5),(14,'Mehtab Bagh view across Yamuna',6);

-- 15. Agra Fort
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (15,'4.5','2 hrs','🏯','#E6F1FB');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (15,'🏯',1),(15,'🔴',2),(15,'👑',3),(15,'🏛️',4),(15,'🌆',5),(15,'🗡️',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(15,'👑','Imperial Chambers Tour','Walk through Diwan-i-Aam (Hall of Public Audience) and Khas Mahal.',1),
(15,'🌆','Taj Mahal View Point','Shah Jahan spent his last years imprisoned here — gazing at the Taj.',2),
(15,'🔴','Sandstone Architecture','Study the contrast of red sandstone and white marble inlays up close.',3),
(15,'🎭','Sound & Light Show','Evening show recreating dramatic Mughal court life inside the fort.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(15,'Diwan-i-Aam',1),(15,'Khas Mahal',2),(15,'Musamman Burj (Shah Jahan\'s prison)',3),
(15,'Jahangir\'s Palace',4),(15,'Nagina Masjid',5),(15,'Taj Mahal view from the fort',6);

-- 16. Mehtab Bagh
INSERT INTO place_meta (place_id, rating, duration, emoji, bg_color) VALUES (16,'4.3','1 hr','🌙','#EAF3DE');
INSERT INTO place_photos (place_id, photo_emoji, sort_order) VALUES (16,'🌙',1),(16,'🌸',2),(16,'🌅',3),(16,'🦋',4),(16,'🌿',5),(16,'🪷',6);
INSERT INTO place_activities (place_id, icon, name, description, sort_order) VALUES
(16,'📸','Taj Reflection Shot','Best long-lens view of the Taj across the Yamuna — without the massive crowds.',1),
(16,'🌅','Sunset Viewing','Watch the Taj Mahal turn from amber to pale ivory as light fades.',2),
(16,'🌸','Mughal Garden Stroll','Walk among Mughal-era fountain channels and geometric flowerbeds.',3),
(16,'🦋','Quiet Nature Walk','Butterflies, birds, and river breeze — a peaceful alternative to the Taj.',4);
INSERT INTO place_popular (place_id, thing_name, sort_order) VALUES
(16,'Sunset Taj Mahal reflection',1),(16,'Yamuna riverbank walk',2),(16,'Mughal garden layout',3),
(16,'Photography without crowds',4),(16,'Quiet alternative to Taj',5),(16,'River boat rides nearby',6);

SELECT 'Place detail tables seeded successfully!' AS status;
