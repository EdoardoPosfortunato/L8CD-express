import db from "../db.js";

export async function generateShoeSeederString() {
  const [rows] = await db.query("SELECT * FROM l8cd_db.products;");

  const seederArray = rows.map((row) => {
    return `{
  id: "${row.id}",
  name: "${row.name}",
  description: "${row.description}",
  stock: "${row.stock}",
  brand: "${row.brand}",
  category_id: ${row.category_id},
  price: "${row.price}"
  color: "${row.color}"
  size: "${row.size}"
  created_at: "${row.created_at}"
  updated_at: "${row.updated_at}"
}`;
  });

  const seederString = `const shoes = [\n${seederArray.join(",\n")}\n];`;
  return seederString;
}
