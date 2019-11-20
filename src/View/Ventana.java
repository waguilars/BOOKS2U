package View;

import CLIPSJNI.Environment;
import CLIPSJNI.PrimitiveValue;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Ventana extends JFrame {
    private JLabel lblTitle;
    private JLabel lblDescription;
    private JLabel lblautores;
    private JButton btnInit;
    private JButton btnExit;
    private Environment clips;
    private final String ARCHIVO_DE_CLIPS = "books.CLP";

    public Ventana(String title){
        super(title);
        init();
    }

    private void init(){

        this.setSize(300, 250);
        this.getContentPane().setLayout(null);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.setLocationRelativeTo(null);
        this.setResizable(false);

        // titulo
        lblTitle = new JLabel("Sistema Experto BOOKS2U");
        lblTitle.setBounds(10, 10, 250, 30);
        lblTitle.setFont(new Font("TimesRoman", Font.BOLD, 16));
        this.add(lblTitle);

        //Descripscion
        lblDescription = new JLabel("<html>Este sistema experto te ayuda \na escoger un libro segun tus preferencias.</html>");
        lblDescription.setBounds(10, 40 , this.getWidth(), 50);
        lblDescription.setFont(new Font("TimesRoman", Font.PLAIN, 12));
        this.add(lblDescription);

        //btInit
        btnInit = new JButton("Iniciar test");
        btnInit.setBounds(this.getWidth()/4, 100 , 120, 30);
        btnInit.addActionListener(e -> initClips(ARCHIVO_DE_CLIPS));
        this.add(btnInit);

        //boton salir
        btnExit = new JButton("Salir");
        btnExit.setBounds(this.getWidth()/4, 150, 120, 30);
        btnExit.addActionListener(e -> System.exit(0));
        this.add(btnExit);
        //autores 
        lblautores = new JLabel("<html>Integrantes: Wilson Aguilar, Gabriel Cacuango,             Christian Lasso , Laverde Pablo .</html>");
        lblautores.setBounds(10, 175 , this.getWidth(), 50);
        lblautores.setFont(new Font("TimesRoman", Font.PLAIN, 12));
        this.add(lblautores);
    }

    private void initClips(String clipsFile){
        clips = new Environment();
        clips.load(clipsFile);
        clips.reset();
        clips.run();
        try{
            String evaluar = "(find-all-facts ((?x nodo-pregunta-respuesta )) TRUE)";
            PrimitiveValue value = clips.eval(evaluar);
            String valor = value.get(0).getFactSlot("valor").toString();
            System.out.println(valor);
            int option = JOptionPane.showConfirmDialog(null, valor, "BOOKS2U", JOptionPane.YES_NO_OPTION);
            while (option != -1){
                if (option == JOptionPane.YES_NO_OPTION){
                    clips.eval("(assert (opcion si))");
                } else{
                    clips.eval("(assert (opcion no))");
                }
                clips.run();
                evaluar = "(find-all-facts ((?x nodo-pregunta-respuesta )) TRUE)";
                value = clips.eval(evaluar);
                String tipo = value.get(0).getFactSlot("tipo").toString();
                System.out.println(tipo);
                valor = value.get(0).getFactSlot("valor").toString();
                System.out.println(valor);
                if (tipo.equals("decision")) {
                    option = JOptionPane.showConfirmDialog(null, valor, "BOOKS2U", JOptionPane.YES_NO_OPTION);
                }else {
                    if(tipo.equals("respuesta")){

                        JOptionPane.showMessageDialog(null, valor , "Mensaje",JOptionPane.INFORMATION_MESSAGE);

                        option = -1;

                    }

                }

            }



        }catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, ex.getMessage(),"ERROR",JOptionPane.ERROR_MESSAGE);
        }
    }
}
