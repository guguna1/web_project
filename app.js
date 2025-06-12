import express from 'express';
const app = express();
app.set("view engine", "ejs");
import {getProductsByCategory,getProductById} from './database.js';


//main page
app.get ("/", (req, res) => {
    res.render("home.ejs")
});
app.get('/products/:category', async (req, res) => {
  const category = req.params.category;
  const page = parseInt(req.query.page) || 1;
  const limit = 5;
  const offset = (page - 1) * limit;

  try {
    const result = await getProductsByCategory(category, limit, offset);
    if (!result.products.length) {
      res.status(404).json({ error: 'Category not found or no products' });
      return;
    }
    res.json(result);
  } catch {
    res.status(500).json({ error: 'Server error' });
  }
});

//product page

app.get('/product/:id', async (req, res) => {
  const id = parseInt(req.params.id);
  if (isNaN(id)) {
    return res.status(400).send('Invalid product ID');
  }

  try {
    const product = await getProductById(id);
    if (!product) {
      return res.status(404).send('Product not found');
    }
    res.render('product.ejs', { product });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});




app.use(express.static('global'));
app.use((err, req, res, next) => { 
console.error(err.stack) 
res.status(500).send('Something broke!') 
}) 
const port = 7777;
app.listen(port, () => { 
console.log('Server is running on port 3000')
})