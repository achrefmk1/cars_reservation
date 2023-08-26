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
import Icon from "react-native-vector-icons/FontAwesome";

const AgencyServicesScreen = ({ navigation, route }) => {
  const { agency, token } = route.params;
  const [services, setServices] = useState([]);
  const [service, setService] = useState("");
  const [period, setPeriod] = useState("");
  const [times, setTimes] = useState("");
  const [selectedServiceId, setSelectedServiceId] = useState(null);

  useEffect(() => {
    console.log(agency);
    getServices();
  }, []);

  async function getServices() {
    await axios
      .get("http://127.0.0.1:8000/api/agencies/services/" + agency.id, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((resp) => {
        setServices(resp.data);
      });
  }

  const handleSaveService = async () => {
    try {
      if (selectedServiceId === null) {
        await axios
          .post(
            "http://127.0.0.1:8000/api/agencies/services/store",
            {
              service,
              period,
              times,
              agency_id: agency.id,
            },
            {
              headers: {
                Authorization: `Bearer ${token}`,
              },
            }
          )
          .then((resp) => {
            getServices();
            setService("");
            setPeriod("");
            setTimes("");
          });
      } else {
        await axios
          .put(
            "http://127.0.0.1:8000/api/agencies/services/" + selectedServiceId,
            {
              service,
              period,
              times,
              agency_id: agency.id,
            },
            {
              headers: {
                Authorization: `Bearer ${token}`,
              },
            }
          )
          .then((resp) => {
            getServices();
            setService("");
            setPeriod("");
            setTimes("");
          });
      }
    } catch (error) {
      console.error("Create service error:", error);
    }
  };

  const handleEditService = (service) => {
    setSelectedServiceId(service.id);
    setService(service.service);
    setPeriod(service.period);
    setTimes(service.times);
  };

  // const handleDeleteService = async (serviceId) => {
  //   await axios
  //     .post(
  //       "http://127.0.0.1:8000/api/agencies/services/toggleStatus/" + serviceId,
  //       {},
  //       {
  //         headers: {
  //           Authorization: `Bearer ${token}`,
  //         },
  //       }
  //     )
  //     .then((resp) => {
  //       getServices();
  //     });
  // };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Services de l'agence {agency.name}</Text>
      <FlatList
        data={services}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.serviceItem}>
            <Text style={styles.name}>{`${item.service}`}</Text>
            <TouchableOpacity
              onPress={() => handleEditService(item)}
              style={styles.actionButton}
            >
              <Icon name="pencil" size={20} color="#007AFF" />
              {/* <FontAwesome5 name="pencil" size={24} color="red" /> */}
            </TouchableOpacity>
            <TouchableOpacity
              // onPress={() => handleDeleteCar(item.id)}
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
          placeholder="Nom du service"
          value={service}
          onChangeText={setService}
        />
        <TextInput
          style={styles.input}
          placeholder="Durée Estimée"
          value={period}
          onChangeText={setPeriod}
        />
        <TextInput
          style={styles.input}
          placeholder="service en parallèle"
          value={times}
          onChangeText={setTimes}
          keyboardType="numeric"
        />
        <TouchableOpacity onPress={handleSaveService} style={styles.button}>
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
  name: {
    fontSize: 18,
    fontWeight: "bold",
    flex: 1,
  },
  deleteButton: {
    backgroundColor: "red",
    padding: 5,
    borderRadius: 5,
  },
  serviceItem: {
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

export default AgencyServicesScreen;
