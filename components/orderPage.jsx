const OrderConfirmationEmail = ({ name, products, total }) => {
  return (
    <div style={{ fontFamily: "Arial", color: "#333", fontSize: "16px" }}>
      <h2>Ciao {name},</h2>
      <p>Grazie per il tuo ordine! Ecco il riepilogo:</p>

      <ul>
        {products.map((item, index) => (
          <li key={index}>
            Prodotto #{item.product_id} – Quantità: {item.quantity}
          </li>
        ))}
      </ul>

      <p>
        <strong>Totale:</strong> €{total}
      </p>
      <p>Ti informeremo appena l'ordine sarà spedito.</p>
    </div>
  );
};

export default OrderConfirmationEmail;
