# 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL?
`Foreign key` এবং `Primary Key` দিয়ে এক বা একাধিক টেবিল এর মধ্যে ডাটা ইন্টিগ্রিটি বজায় রেখে রিলেশনশিপ তৈরি করা হয়। যাতে পরবর্তীতে তাদের মধ্যে কুয়েরি করে প্রয়োজন মত ডাটা খুজে বের করা যায়। যেহেতু টেবিল তৈরির সময় ডাটা রিডান্ডেন্সি ও কন্সিস্টেন্সি বজায় রাখতে নরমালাইজেশন মাথায় রাখতে হয় তখন একাধিক টেবিল তৈরি হয়। তখন প্রয়োজনীয় ডাটা খুজে বের করতে আমাদের একাধিক টেবিল এর মধ্যে সংযোগ স্থাপন করতে হয় এবং জয়েন অপারেশন করে ডাটা বের করতে হয়।
#### a. Primary Key:
প্রাইমারি কি ইউনিক হতে হবে এবং নাল হওয়া যাবে না। প্রাইমারি কি দিয়ে একটা টেবিল এর প্রতিটা সারিকে ইউনিকলি খুজে বের করা যাবে। একটা টেবিল এর প্রাইমারি কি একটা কলাম বা একাধিক কলাম নিয়ে হতে পারে। তবে একটা টেবিল এর ১টাই প্রাইমারি কি থাকতে পারবে। যেমনঃ
```sql
CREATE TABLE species (
    species_id INT PRIMARY KEY,
    common_name VARCHAR(100),
);
```

#### b. Foreign Key:
ফরেন কি দিয়ে প্যারেন্ট চাইল্ড রিলেশনশিপ তৈরি করা হয়। একটা টেবিল(১ম টেবিল) এর প্রাইমারি কি কে অন্য আরেকটা টেবিল(২য় টেবিল) এ রেফারেন্স এর মাধ্যমে ফরেন কি হিসাবে ব্যবহার করা হয়। ফরেন কি যুক্ত টেবিল এ ডাটা ইনসার্ট করার সময় খেয়াল রাখতে হয় যেন যেই টেবিল কে রেফারেন্স করতেছে সেটার ডাটার সাথে কন্সিস্টেন্সি বজায় থাকে। একটা টেবিল এ একাধিক ফরেন কি থাকতে পারে। ডিলিট করার সময় আগে ১ম টেবিল এর ডাটা ডিলিট করতে হয়, তারপর ফরেন কি যুক্ত টেবিল এর ডাটা ডিলিট করতে হয়। কারন তা না হলে অসামঞ্জস্য তৈরি হতে পারে। এটা ডিফল্ট বিহ্যাভিওর তবে ON DELETE CASCADE, ON DELETE SET NULL  সহ আরো কিছু উপায়ে ডিলিট অপারেশন হ্যান্ডেল করা যায়।
```sql
CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    ranger_id INT,
    FOREIGN KEY (species_id) REFERENCES species(species_id), -- এখানে species টেবিল এর প্রাইমারি কি কে ফরেন কি হিসাবে ব্যবহার করে ২ টেবিল এর মধ্যে রিলেশন তৈরি করা হয়েছে।
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);
```


# 4. What is the difference between the VARCHAR and CHAR data types?
`VARCHAR` এবং `CHAR` এই দুইটি ডেটাটাইপের মধ্যে পার্থক্য হচ্ছে টেক্সটের দৈর্ঘ্য, স্টোরেজ এবং পারফরম্যান্স এর মধ্যে কমবেশি।
#### a. VARCHAR(n):
1. সর্বোচ্চ n সংখ্যক অক্ষর রাখতে পারে।
2. যতটুকু অক্ষর থাকবে, ততটুকুই স্টোরেজ ব্যবহার করে।
3. বাড়তি জায়গা প্যাড করে না অর্থাৎ অতিরিক্ত স্পেস যোগ করে না।
```sql
name VARCHAR(20);
name('Jakir') -- ৫ টা ক্যারেক্টার এর জায়গা নিবে
```
#### b. CHAR(n)
1. সবসময় n সংখ্যক অক্ষরই রাখবে
2. যদি স্ট্রিং ছোট হয়, তাহলে ডানদিকে স্পেস দিয়ে পূরণ করে (padding)
```sql
name VARCHAR(5)
name ('USA') --- 'USA  ' এভাবে রাখবে। 
```


# 5. Explain the purpose of the WHERE clause in a SELECT statement?
`SELECT` এবং `WHERE` ক্লজ ব্যবহার করে কন্ডিশন এর উপর বেজ করে একটা টেবিল এর ডাটা রিট্রাইভ করা হয়। ফলে অনেক ইফিশিয়েন্টলি এবং স্পেসিফিক ডাটা বের করা যায়। 
#### a. WHERE:
একটা টেবিল এ অনেক সারি থাকতে পারে সকল সারি আমাদের প্রয়োজন নাও হতে পারে। `WHERE` ক্লজ দিয়ে ঐ সকল সারিকে আমরা সিলেক্ট করব যেই স
সকল সারিকে আমাদের প্রয়োজন। এখানে বিভিন্ন কন্ডিশনাল অপারেটর ব্যবহার করা হয়। আবার `LIKE` `IS NULL` etc ও ব্যবহার করা যায়।

#### b. SELECT:
সিলেক্ট দিয়ে একটা টেবিলের নির্দিষ্ট কিছু কলামকে রিট্রাইভ করা হয়। এতে কুয়েরি অনেক ফাস্ট হয়। অপ্রয়োজনীয় ডাটা আসে না।
যেমনঃ
```sql
SELECT name FROM rangers
WHERE region = 'River Delta'; -- এখানে SELECT দিয়ে শুধুমাত্র name column কে এবং এই কলাম এর যেই সকল সারি এর region = 'River Delta' সেই সকল সারিকে রিট্রাইভ করতে WHERE clause ব্যবহার করা হয়েছে।
```

# 6. What are the LIMIT and OFFSET clauses used for?
`লিমিট` দিয়ে একটা সিলেক্ট কুয়েরি এর কতগুলো সারি দেখানো হবে এবং `অফসেট` ক্লজ দিয়ে কতগুলো সারি স্কিপ করা হবে তা নির্ধারন করা হয়। এই দুই ক্লজ দিয়ে পেজিনেশন করা হয়। যার মাধ্যমে আমরা একটা বড় ডাটাবেজ থেকে একটা নির্দিষ্ট পরিমানে ডাটা দেখাতে পারি।
#### a. LIMIT:
`লিমিট` দিয়ে একটা সিলেক্ট কুয়েরি এর কতগুলো সারি দেখানো হবে তা নির্দিষ্ট করে দেয়া হয়।
```sql
SELECT * FROM sightings
LIMIT 5; -- এটার মাধ্যমে বলা হচ্ছে যে প্রথম ৫টা ডাটা দেখাতে হবে।
```

#### b. OFFSET:
`অফসেট` ক্লজ দিয়ে কতগুলো সারি স্কিপ করা হবে তা নির্ধারন করা হয়। যেমন উপরের `লিমিট` এর ঐখানে আমরা যদি প্রথম ১০ টা সারি বাদ দিয়ে তার পর থেকে ৫ টা ডাটা দেখাতে চাই তাহইলে `লিমিট` এর মান ৫ এবং `অফসেট` এর মান ১০ দিতে হবে।
We can define unions and intersections using `type`. But `interface` doesn't provide these types of functionalities.
```sql
SELECT * FROM sightings
LIMIT 5
OFFSET 10
```


# 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
`Aggregate function` গুলো একটা গ্রুপের উপরে কাজ করে। `COUNT(*)` দিয়ে একটা টেবিল এর কয়টা সারি আছে তা বের করা যায়। আবার গ্রুপে ভাগ করলে ঐ গ্রুপের আন্ডারে কয়টা সারি আছে তা বের করা যায়। একই ভাবে অন্য aggregate function গুলোও কাজ করে। যেমনঃ
#### 1. COUNT():
```sql
SELECT name, COUNT(*) as total_sightings FROM sightings 
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id 
    GROUP BY rangers.name 
    ORDER BY rangers.name ASC; --- প্রতিজন rangers কতগুলো sighting করেছে তা বের করার জন্যে ব্যবহার হচ্ছে
```

#### 2. SUM():
`Sum` দিয়ে যেই কলাম এর ডাটা এর যোগফল চাচ্ছি তা বলে দিলে সেটা পাব।
```sql
SELECT SUM(species_id) FROM sightings;
```

#### 3. AVG():
`AVG` দিয়ে যেই কলাম এর ডাটা এর এভারেজ চাচ্ছি তা বলে দিলে সেটা পাব।
```sql
SELECT AVG(species_id) FROM sightings;
```
