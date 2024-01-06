module ec.edu.espol.petbackersbd {
    requires javafx.controls;
    requires javafx.fxml;

    opens ec.edu.espol.petbackersbd to javafx.fxml;
    exports ec.edu.espol.petbackersbd;
}
