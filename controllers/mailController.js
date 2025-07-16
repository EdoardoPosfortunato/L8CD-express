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

    res.status(200).json({ message: "Email inviata con successo (test)" });
  } catch (error) {
    console.error("Errore invio mail:", error);
    res.status(500).json({ message: "Errore durante l'invio dell'email" });
  }
};

export default { subscribe };
