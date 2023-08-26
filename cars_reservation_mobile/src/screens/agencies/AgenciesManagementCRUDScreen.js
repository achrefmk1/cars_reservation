import React, { useState, useEffect } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  Modal,
  StyleSheet,
  Switch,
  FlatList,
} from "react-native";
// import CheckBox from "@react-native-community/checkbox";
import axios from "axios";
import { Feather, FontAwesome5 } from "@expo/vector-icons";

const AgenciesManagementCRUDScreen = ({ navigation, route }) => {
  const token = route.params.token;
  const [agencies, setAgencies] = useState([]);
  const [name, setName] = useState("");
  const [adresse, setAdresse] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [start, setStart] = useState("");
  const [selectedAgencyId, setSelectedAgencyId] = useState(null);
  const [showWorkDaysModal, setShowWorkDaysModal] = useState(false);
  const [workDays, setWorkDays] = useState([]);
  const [update, setUpdate] = useState(false);

  const toggleWorkDay = (day) => {
    if (workDays.includes(day)) {
      setWorkDays(workDays.filter((d) => d !== day));
    } else {
      setWorkDays([...workDays, day]);
    }
  };

  useEffect(() => {
    fetchAgenciesData();
  }, []);

  const fetchAgenciesData = async () => {
    try {
      const response = await axios.get("http://127.0.0.1:8000/api/agencies", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setAgencies(response.data.data);
    } catch (error) {
      console.error("Error fetching agencies:", error);
    }
  };

  const save = () => {
    if (update) {
      handleUpdateAgency();
    } else {
      handleAddAgency();
    }
  };

  const handleAddAgency = async () => {
    const newAgency = {
      name,
      adresse,
      phone,
      email,
      workDays: JSON.stringify(workDays),
      start,
    };

    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/agencies",
        newAgency,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      fetchAgenciesData();

      // Clear input fields
      setName("");
      setAdresse("");
      setPhone("");
      setEmail("");
      setWorkDays([]);
      setStart("");
    } catch (error) {
      console.error("Error adding agency:", error);
    }
  };

  const handleEditAgency = (agencyToEdit) => {
    setUpdate(true);
    setSelectedAgencyId(agencyToEdit.id);
    setName(agencyToEdit.name);
    setAdresse(agencyToEdit.adresse);
    setPhone(agencyToEdit.phone);
    setEmail(agencyToEdit.email);
    setWorkDays(JSON.parse(agencyToEdit.workDays));
    setStart(agencyToEdit.start);
  };

  const handleUpdateAgency = async () => {
    const updatedAgency = {
      name,
      adresse,
      phone,
      email,
      workDays: JSON.stringify(workDays),
      start,
    };

    try {
      const response = await axios.put(
        `http://127.0.0.1:8000/api/agencies/${selectedAgencyId}`,
        updatedAgency,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      const updatedAgencies = agencies.map((agency) =>
        agency.id === selectedAgencyId ? response.data : agency
      );

      setAgencies(updatedAgencies);

      // Clear input fields and selectedAgencyId
      setSelectedAgencyId(null);
      setName("");
      setAdresse("");
      setPhone("");
      setEmail("");
      setWorkDays([]);
      setStart("");
      setUpdate(false);
    } catch (error) {
      console.error("Error updating agency:", error);
    }
  };

  const handleDeleteAgency = async (agencyId) => {
    try {
      await axios.delete(`http://127.0.0.1:8000/api/agencies/${agencyId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const updatedAgencies = agencies.filter(
        (agency) => agency.id !== agencyId
      );
      setAgencies(updatedAgencies);
    } catch (error) {
      console.error("Error deleting agency:", error);
    }
  };

  return (
    <View style={styles.container}>
      <FlatList
        data={agencies}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.agencyItem}>
            <Text style={styles.title}>
              <TouchableOpacity
                onPress={() =>
                  navigation.navigate("Détails", {
                    navigation,
                    token,
                    agency: item,
                  })
                }
                style={styles.actionButton}
              >
                {item.name}
              </TouchableOpacity>
            </Text>
            <TouchableOpacity
              onPress={() => handleEditAgency(item)}
              style={styles.actionButton}
            >
              <Feather name="edit" size={20} color="#007AFF" />
            </TouchableOpacity>
            <TouchableOpacity
              onPress={() => handleDeleteAgency(item.id)}
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
          placeholder="Nom de l'agence..."
          value={name}
          onChangeText={setName}
        />
        <TextInput
          style={styles.input}
          placeholder="Adresse"
          value={adresse}
          onChangeText={setAdresse}
        />
        <TextInput
          style={styles.input}
          placeholder="Téléphone"
          value={phone}
          onChangeText={setPhone}
        />
        <TextInput
          style={styles.input}
          placeholder="Email"
          value={email}
          onChangeText={setEmail}
          keyboardType="email-address"
        />
        <TouchableOpacity
          onPress={() => setShowWorkDaysModal(true)}
          style={styles.workDaysInput}
        >
          <Text>
            {workDays.length > 0 ? workDays.join(", ") : "Jours de travail"}
          </Text>
        </TouchableOpacity>
        <TextInput
          style={styles.input}
          placeholder="Temps d'ouverture ex: 08:00"
          value={start}
          onChangeText={setStart}
        />
        <TouchableOpacity onPress={save} style={styles.button}>
          <Text style={styles.buttonText}>Enregistrer</Text>
        </TouchableOpacity>
      </View>

      {showWorkDaysModal && (
        <Modal
          visible={showWorkDaysModal}
          animationType="slide"
          transparent={true}
        >
          <View style={styles.modalContainer}>
            <View style={styles.modalContent}>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Lundi")}
              >
                <Text>Lundi</Text>
                {workDays.includes("Lundi") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Mardi")}
              >
                <Text>Mardi</Text>
                {workDays.includes("Mardi") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Mercredi")}
              >
                <Text>Mercredi</Text>
                {workDays.includes("Mercredi") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Jeudi")}
              >
                <Text>Jeudi</Text>
                {workDays.includes("Jeudi") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Vendredi")}
              >
                <Text>Vendredi</Text>
                {workDays.includes("Vendredi") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Samedi")}
              >
                <Text>Samedi</Text>
                {workDays.includes("Samedi") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => toggleWorkDay("Dimanche")}
              >
                <Text>Dimanche</Text>
                {workDays.includes("Dimanche") && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </TouchableOpacity>
              <TouchableOpacity
                onPress={() => setShowWorkDaysModal(false)}
                style={styles.closeButton}
              >
                <Text style={styles.closeButtonText}>Close</Text>
              </TouchableOpacity>
            </View>
          </View>
        </Modal>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  title: {
    fontSize: 18,
    fontWeight: "bold",
    flex: 1,
  },
  agencyItem: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 20,
    borderBottomWidth: 1,
    borderBottomColor: "#ccc",
  },
  actionButton: {
    marginLeft: 10,
  },
  container: {
    flex: 1,
    padding: 20,
  },
  inputContainer: {
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    padding: 10,
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
  label: {
    fontSize: 16,
    marginBottom: 5,
  },
  workDaysInput: {
    height: 40,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    marginBottom: 10,
    paddingHorizontal: 10,
    justifyContent: "center",
  },
  modalContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "rgba(0, 0, 0, 0.5)",
  },
  modalContent: {
    backgroundColor: "#fff",
    padding: 20,
    borderRadius: 10,
  },
  switchContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 10,
  },
  addButton: {
    backgroundColor: "#007AFF",
    padding: 10,
    borderRadius: 5,
    alignItems: "center",
  },
  buttonText: {
    color: "#fff",
    fontSize: 16,
  },
  closeButton: {
    marginTop: 10,
    alignSelf: "flex-end",
  },
  closeButtonText: {
    color: "blue",
  },
  editContainer: {
    backgroundColor: "#f9f9f9",
    padding: 10,
    marginBottom: 20,
  },
  editButton: {
    backgroundColor: "#007AFF",
    padding: 5,
    borderRadius: 5,
    marginRight: 10,
  },
  updateButton: {
    backgroundColor: "green",
    padding: 10,
    borderRadius: 5,
    alignItems: "center",
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

export default AgenciesManagementCRUDScreen;
