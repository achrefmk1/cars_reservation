import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  Picker,
  TextInput,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import axios from "axios";
import DatePicker from "react-datepicker";

import "react-datepicker/dist/react-datepicker.css";

const RDVScreen = ({ navigation, route }) => {
  const { agency, service, token } = route.params;
  const [selectedOption, setSelectedOption] = useState("1");
  const [selectedDate, setSelectedDate] = useState("");
  const [cars, setCars] = useState([]);

  useEffect(() => {
    getCars();
  }, []);

  async function getCars() {
    await axios
      .get("http://127.0.0.1:8000/api/cars", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((resp) => {
        setCars(resp.data.data);
      });
  }

  const handleSaveRDV = () => {
    // Implement your logic to save the RDV
    // You can use selectedOption and selectedDate
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Rendez-vous chez "{agency.name}"</Text>
      <Text style={styles.subtitle}>pour "{service.service}"</Text>

      <View style={styles.formGroup}>
        <Text style={styles.label}>Selectionner ta voiture:</Text>
        <Picker
          style={styles.carPicker}
          selectedValue={selectedOption}
          onValueChange={(itemValue) => setSelectedOption(itemValue)}
        >
          {cars.map((car, index) => (
            <Picker.Item key={index} label={car.model} value={car.id} />
          ))}
        </Picker>
      </View>

      <View style={styles.formGroup}>
        <Text style={styles.label}>Selectionner la Date:</Text>
        <DatePicker
          style={styles.datePicker}
          selected={selectedDate}
          onChange={(date) => setSelectedDate(date)}
          dateFormat="yyyy-MM-dd"
        />
      </View>
      <Text style={styles.danger}>c'est un jour férié</Text>
      {/* <Text style={styles.success}>votre rendez-vous sera à 12h00</Text> */}
      {/* <Text style={styles.danger}>cette date n'est pas disponible</Text>
      <Text style={styles.danger}>choisisser une autre date</Text> */}

      <TouchableOpacity style={styles.button} onPress={handleSaveRDV}>
        Vérifier
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  button: {
    backgroundColor: "#183658",
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: "center",
    color: "white",
    marginTop: 15,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 15,
  },
  danger: {
    color: "#fa5858",
  },
  success: {
    color: "#4cbb8a",
  },
  subtitle: {
    fontSize: 18,
    fontWeight: "bold",
    marginBottom: 20,
  },
  formGroup: {
    marginBottom: 20,
  },
  label: {
    fontSize: 16,
    marginBottom: 5,
  },
  input: {
    width: 200,
    height: 40,
    borderColor: "gray",
    borderWidth: 1,
    marginVertical: 10,
    paddingHorizontal: 8,
    backgroundColor: "white",
    opacity: 1,
  },
  datePicker: {
    width: 200,
    height: 40,
    borderColor: "gray",
    borderWidth: 1,
    marginVertical: 10,
    paddingHorizontal: 8,
    backgroundColor: "white",
    opacity: 1,
    justifyContent: "center",
  },
  carPicker: {
    width: 200,
    height: 40,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    marginBottom: 10,
  },
});

export default RDVScreen;
