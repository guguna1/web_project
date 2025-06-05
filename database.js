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

