# PharmaFinder

**PharmaFinder** is a web application built using **JSP**, **Servlet**, **JDBC**, and **MySQL** that helps customers quickly find the nearest pharmacy stocking their desired medication.

## Authors

* [**Talha Aziz**](https://github.com/taaziz1)
* [**Shreya Maipady**](https://github.com/maipadyshreya)
* [**Le Duy Nguyen**](https://github.com/LeDuyNg)

## Technologies Used

* **MySQL** – [Download](https://dev.mysql.com/downloads/mysql/)
* **Apache Tomcat 11.0.9** (or later) – [Download](https://tomcat.apache.org)
* **MySQL JDBC Driver** – [Download](https://dev.mysql.com/downloads/connector/j/)

## Project Overview

The goal of PharmaFinder is to provide a user-friendly platform where customers can:

* Search for medications and find the **nearest pharmacy** with the item in stock
* View detailed pharmacy information, including **distance** and **travel time** from their location
* Search by **medication type**, **medication name**, or **pharmacy name**
* Leave and manage **reviews** about pharmacies

Pharmacies can:

* **Register** on the platform and manage their account
* **Add, edit, and remove medications** from their inventory
* Update their store details to reach more customers

## Features

### **Customer Features**

* **Account Registration** – Create a customer account with password complexity checks and required field validation
* **Change Avatar** – Choose from 10 preset avatars with confirmation message upon update
* **Change Password** – Requires old password; enforces complexity rules and prevents reusing the current password
* **Delete Account** – Requires password verification; removes customer data, reviews, and account credentials
* **View Reviews** – See all personal reviews in chronological order, with direct links to the corresponding pharmacy
* **Post Reviews** – Submit one review per pharmacy; removes review form after posting; stored in the Review table
* **Edit Reviews** – Modify existing reviews with updated database entries
* **Delete Reviews** – Confirmation prompt before deletion; updates Review table

### **Pharmacy Features**

* **Pharmacy Registration** – Register with business details, tax number, and store address
* **Manage Store Information** – Update store details with the same validation as registration; changes reflected in database tables
* **Change Password** – Requires tax number and old password; enforces complexity rules and prevents reusing the current password
* **Delete Account** – Requires tax number and password; removes all associated data, including reviews and address records
* **Medication Management** – Add, edit, and delete medications in inventory

### **Search & Navigation**

* Search by **medication name**, **medication type**, or **pharmacy name**
* Display nearest pharmacies with **distance and travel time** using the customer’s input address
* Distance-based ordering of results

## Setup Instructions

1. **Clone the Repository**

```bash
git clone https://github.com/taaziz1/CS157A-team1.git
```

2. **Import the Database**

    * Open MySQL Workbench
    * Import the database file `pharmafinderdb.sql` located in the project folder

3. **Import the Project into Your IDE**

    * Use Eclipse, IntelliJ IDEA, or any Java IDE
    * Import as a **Maven project**

4. **Configure Tomcat**

    * Set up **Apache Tomcat 11.0.9** (or later) in your IDE
    * Add the project to your Tomcat server

5. **Set Up Database Credentials**

    * Create a `database.properties` file inside the `Tomcat/conf/` directory with the following:

```properties
user=<Your MySQL username>
pass=<Your MySQL password>
apiKey=<Will be provided separately>
```

6. **Run the Application**

    * Start the Tomcat server
    * Open your browser and go to:

      ```
      http://localhost:8080/PharmaFinder/
      ```

---