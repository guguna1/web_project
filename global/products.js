const state = {
  Electronics: { page: 1, total: 0 },
  'Sports Equipment': { page: 1, total: 0 },
  'Home Appliances': { page: 1, total: 0 }
};

async function fetchProducts(category) {
  const page = state[category].page;
  try {
    const response = await fetch(`/products/${encodeURIComponent(category)}?page=${page}`);
    if (!response.ok) {
      alert('Failed to load products for ' + category);
      return;
    }
    const data = await response.json();
    state[category].total = data.total;
    renderProducts(category, data.products);
    updateButtons(category);
  } catch (err) {
    alert('Error fetching products for ' + category);
    console.error(err);
  }
}

function renderProducts(category, products) {
  const containerId = category.toLowerCase().replace(/\s+/g, '-') + '-products';
  const container = document.getElementById(containerId);
  container.innerHTML = products.map(p => `
    <div class="product">
      <a href="/product/${p.id}" target="_blank">
        <img src="${p.image_url}" alt="${p.name}" />
        <h3>${p.name}</h3>
        <p>$${p.price}</p>
      </a>
    </div>
  `).join('');
}


function updateButtons(category) {
  const prevBtn = document.getElementById(category.toLowerCase().replace(/\s+/g, '-') + '-prev');
  const nextBtn = document.getElementById(category.toLowerCase().replace(/\s+/g, '-') + '-next');
  const page = state[category].page;
  const totalPages = Math.ceil(state[category].total / 5);

  prevBtn.disabled = page <= 1;
  nextBtn.disabled = page >= totalPages;
}

// Electronics
document.getElementById('electronics-prev').addEventListener('click', () => {
  if (state.Electronics.page > 1) {
    state.Electronics.page--;
    fetchProducts('Electronics');
  }
});
document.getElementById('electronics-next').addEventListener('click', () => {
  state.Electronics.page++;
  fetchProducts('Electronics');
});

// Sports Equipment
document.getElementById('sports-equipment-prev').addEventListener('click', () => {
  if (state['Sports Equipment'].page > 1) {
    state['Sports Equipment'].page--;
    fetchProducts('Sports Equipment');
  }
});
document.getElementById('sports-equipment-next').addEventListener('click', () => {
  state['Sports Equipment'].page++;
  fetchProducts('Sports Equipment');
});

// Home Appliances
document.getElementById('home-appliances-prev').addEventListener('click', () => {
  if (state['Home Appliances'].page > 1) {
    state['Home Appliances'].page--;
    fetchProducts('Home Appliances');
  }
});
document.getElementById('home-appliances-next').addEventListener('click', () => {
  state['Home Appliances'].page++;
  fetchProducts('Home Appliances');
});


fetchProducts('Electronics');
fetchProducts('Sports Equipment');
fetchProducts('Home Appliances');
