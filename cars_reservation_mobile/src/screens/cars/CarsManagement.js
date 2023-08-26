import axios from "axios";
import React, { useState, useEffect } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  FlatList,
  StyleSheet,
} from "react-native";
import { Feather, FontAwesome5 } from "@expo/vector-icons";

const CarsManagementCRUDScreen = ({ navigation, route }) => {
  const token = route.params.token;
  const [cars, setCars] = useState([]);
  const [marque, setMarque] = useState("");
  const [model, setModel] = useState("");
  const [year, setYear] = useState("");
  const [matricule, setMatricule] = useState("");
  const [selectedCarId, setSelectedCarId] = useState(null);

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

  const handleSaveCar = async () => {
    try {
      if (selectedCarId === null) {
        await axios
          .post(
            "http://127.0.0.1:8000/api/cars",
            {
              marque,
              model,
              year,
              matricule,
            },
            {
              headers: {
                Authorization: `Bearer ${token}`,
              },
            }
          )
          .then((resp) => {
            getCars();
            setMarque("");
            setModel("");
            setYear("");
            setMatricule("");
          });
      } else {
        await axios
          .put(
            "http://127.0.0.1:8000/api/cars/" + selectedCarId,
            {
              marque,
              model,
              year,
              matricule,
            },
            {
              headers: {
                Authorization: `Bearer ${token}`,
              },
            }
          )
          .then((resp) => {
            getCars();
            setMarque("");
            setModel("");
            setYear("");
            setMatricule("");
          });
      }
    } catch (error) {
      console.error("Create Car error:", error);
    }
  };

  const handleEditCar = (car) => {
    setSelectedCarId(car.id);
    setMarque(car.marque);
    setModel(car.model);
    setYear(car.year);
    setMatricule(car.matricule);
  };

  const handleDeleteCar = async (carId) => {
    await axios
      .post(
        "http://127.0.0.1:8000/api/cars/toggleStatus/" + carId,
        {},
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      )
      .then((resp) => {
        getCars();
      });
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={cars}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.carItem}>
            <Text style={styles.marque}>{`${item.marque} ${item.model}`}</Text>
            <TouchableOpacity
              onPress={() => handleEditCar(item)}
              style={styles.actionButton}
            >
              <Feather name="edit" size={20} color="#007AFF" />
            </TouchableOpacity>
            <TouchableOpacity
              onPress={() => handleDeleteCar(item.id)}
              style={styles.actionButton}
            >
              {item.isEnabled === "yes" ? (
                <Feather name="eye" size={24} color="green" />
              ) : (
                <FontAwesome5 name="eye-slash" size={24} color="red" />
              )}
            </TouchableOpacity>
          </View>
        )}
      />
      <View style={styles.inputContainer}>
        <TextInput
          style={styles.input}
          placeholder="Marque"
          value={marque}
          onChangeText={setMarque}
        />
        <TextInput
          style={styles.input}
          placeholder="Model"
          value={model}
          onChangeText={setModel}
        />
        <TextInput
          style={styles.input}
          placeholder="Year"
          value={year}
          onChangeText={setYear}
          keyboardType="numeric"
        />
        <TextInput
          style={styles.input}
          placeholder="Matricule"
          value={matricule}
          onChangeText={setMatricule}
        />
        <TouchableOpacity onPress={handleSaveCar} style={styles.button}>
          <Text style={styles.buttonText}>Enregistrer</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
  },
  inputContainer: {
    marginBottom: 20,
  },
  input: {
    height: 40,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    marginBottom: 10,
    paddingHorizontal: 10,
  },
  addButton: {
    backgroundColor: "#007AFF",
    padding: 10,
    borderRadius: 5,
    alignItems: "center",
  },
  buttonText: {
    color: "#fff",
    fontWeight: "bold",
  },
  marque: {
    fontSize: 18,
    fontWeight: "bold",
    flex: 1,
  },
  deleteButton: {
    backgroundColor: "red",
    padding: 5,
    borderRadius: 5,
  },
  carItem: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 20,
    borderBottomWidth: 1,
    borderBottomColor: "#ccc",
  },
  actionButton: {
    marginLeft: 10,
  },
  button: {
    backgroundColor: "#183658",
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: "center",
    color: "white",
  },
});

export default CarsManagementCRUDScreen;
