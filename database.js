import dotenv from 'dotenv';
dotenv.config();
import mysql from 'mysql2';
import bcrypt from 'bcrypt';

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
database: process.env.DB_NAME
}).promise();

export async function addUser(username,email,password,first_name,last_name,location){
    try{
        const hashedPassword = await bcrypt.hash(password, 10);
        
        const [result] = await pool.query (`
            insert into users (username, email, password, first_name, last_name, location)
            values (?, ?, ?, ?, ?, ?)
        `, [username, email, hashedPassword, first_name, last_name, location]);
        console.log("win") 
        return result; 
    }catch (error){
        console.error("sad",error);
        throw error;
    }   
}

export async function getProductsByCategory(category, limit, offset) {
  const [products] = await pool.query(
    `SELECT products.* FROM products
     JOIN categories ON products.category_id = categories.id
     WHERE categories.name = ?
     LIMIT ? OFFSET ?`,
    [category, limit, offset]
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(*) as total FROM products
     JOIN categories ON products.category_id = categories.id
     WHERE categories.name = ?`,
    [category]
  );

  return {
    products,
    total: countResult[0].total
  };
}

export async function getProductById(id) {
  const [rows] = await pool.query(
    `SELECT products.*, categories.name AS category
     FROM products
     JOIN categories ON products.category_id = categories.id
     WHERE products.id = ?`,
    [id]
  );
  return rows[0] || null;
}