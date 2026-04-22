-- User Table
CREATE TABLE User (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Seller Table (1:1 with User)
CREATE TABLE Seller (
  seller_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  business_name VARCHAR(255) NOT NULL,
  approval_status VARCHAR(50),
  CONSTRAINT fk_seller_user
    FOREIGN KEY (user_id)
    REFERENCES User(user_id)
);

-- Product Table
CREATE TABLE Product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  seller_id INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  description TEXT,
  price INT NOT NULL,
  stock INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_product_seller
    FOREIGN KEY (seller_id)
    REFERENCES Seller(seller_id)
);

-- Category Table
CREATE TABLE Category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL
);

-- Product-Category Mapping Table (M:N)
CREATE TABLE ProductCategory (
  product_id INT,
  category_id INT,
  PRIMARY KEY (product_id, category_id),
  CONSTRAINT fk_productcategory_product
    FOREIGN KEY (product_id)
    REFERENCES Product(product_id),
  CONSTRAINT fk_productcategory_category
    FOREIGN KEY (category_id)
    REFERENCES Category(category_id)
);

-- Orders Table
CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  total_amount INT NOT NULL,
  order_status VARCHAR(50),
  ordered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id)
    REFERENCES User(user_id)
);

-- Order Detail Table
CREATE TABLE OrderDetail (
  order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  price INT NOT NULL,
  CONSTRAINT fk_orderdetail_order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),
  CONSTRAINT fk_orderdetail_product
    FOREIGN KEY (product_id)
    REFERENCES Product(product_id)
);

-- Nutrition Diagnosis Result Table
CREATE TABLE NutritionDiagnosisResult (
  diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  diagnosis_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  protein_status VARCHAR(50),
  vitamin_status VARCHAR(50),
  carbohydrate_status VARCHAR(50),
  fat_status VARCHAR(50),
  result_summary TEXT,
  CONSTRAINT fk_diagnosis_user
    FOREIGN KEY (user_id)
    REFERENCES User(user_id)
);

-- Nutrient Table
CREATE TABLE Nutrient (
  nutrient_id INT AUTO_INCREMENT PRIMARY KEY,
  nutrient_name VARCHAR(255) NOT NULL
);

-- Product-Nutrient Mapping Table (M:N)
CREATE TABLE ProductNutrient (
  product_id INT,
  nutrient_id INT,
  content FLOAT,
  PRIMARY KEY (product_id, nutrient_id),
  CONSTRAINT fk_productnutrient_product
    FOREIGN KEY (product_id)
    REFERENCES Product(product_id),
  CONSTRAINT fk_productnutrient_nutrient
    FOREIGN KEY (nutrient_id)
    REFERENCES Nutrient(nutrient_id)
);

-- Payment Table (1:1 with Orders)
CREATE TABLE Payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL UNIQUE,
  payment_amount INT NOT NULL,
  payment_method VARCHAR(50),
  payment_status VARCHAR(50),
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_payment_order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);

-- Cart Table (1:1 with User)
CREATE TABLE Cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_cart_user
    FOREIGN KEY (user_id)
    REFERENCES User(user_id)
);

-- Cart Item Table
CREATE TABLE CartItem (
  cart_id INT,
  product_id INT,
  quantity INT NOT NULL,
  PRIMARY KEY (cart_id, product_id),
  CONSTRAINT fk_cartitem_cart
    FOREIGN KEY (cart_id)
    REFERENCES Cart(cart_id),
  CONSTRAINT fk_cartitem_product
    FOREIGN KEY (product_id)
    REFERENCES Product(product_id)
);

-- Delivery Table (1:1 with Orders)
CREATE TABLE Delivery (
  delivery_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL UNIQUE,
  recipient_name VARCHAR(100),
  contact_number VARCHAR(50),
  address VARCHAR(255),
  address_detail VARCHAR(255),
  delivery_status VARCHAR(50),
  shipped_at DATETIME,
  delivered_at DATETIME,
  CONSTRAINT fk_delivery_order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);