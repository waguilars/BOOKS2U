import View.Ventana;

import javax.swing.*;

public class Main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JFrame ventana = new Ventana("SE BOOKS2U");
            ventana.setVisible(true);
        });

    }
}
