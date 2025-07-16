import transport from "../config/mailer.js";

const subscribe = async (req, res) => {
  const { email } = req.body;

  try {
    await transport.sendMail({
      from: '"La tua Newsletter" <newsletter@l8cd.it>',
      to: email,
      subject: "Conferma iscrizione Newsletter",
      text: "Grazie per l'iscrizione. Ecco il tuo codice coupon: SUMMER15   ",
      html: "<p>Grazie per esserti iscritto alla nostra newsletter! Divertiti questa estate con il tuo codice sconto: SUMMER15</p>",
    });

    console.log(req.body);

    res.status(200).json({ message: "Email inviata con successo (test)" });
  } catch (error) {
    console.error("Errore invio mail:", error);
    res.status(500).json({ message: "Errore durante l'invio dell'email" });
  }
};

const checkout = async (req, res) => {
  const { email, cartItems, name, total } = req.body;

  const itemList = cartItems.map((item) => `<li>${item.name} x${item.quantity}</li>`).join("");

  try {
    await transport.sendMail({
      from: '"Il tuo ordine da L8CD" <ordini@l8cd.it>',
      to: email,
      subject: "Ordine Andato a buon fine",
      html: `
        <p>Grazie per aver effettuato l'ordine da noi. Ecco un riepilogo:</p>
        <ul>${itemList}</ul>
        <p>A presto!</p>
        <p>Totale: ${total}</p>
      `,
    });

    res.status(200).json({ message: "Email di conferma ordine inviata" });
  } catch (error) {
    console.error("Errore invio ordine:", error);
    res.status(500).json({ message: "Problema nell'invio della conferma ordine" });
  }
};

export default { subscribe, checkout };
