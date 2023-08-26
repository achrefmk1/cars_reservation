import React, { useState, useEffect } from "react";
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import axios from "axios";

const AgencyListScreen = ({ navigation, route }) => {
  const token = route.params.token;
  const searchValue = route.params.searchValue;
  const [agencies, setAgencies] = useState([]);

  useEffect(() => {
    fetchAgenciesData();
  }, []);

  const fetchAgenciesData = async () => {
    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/agencies/find",
        {
          adresse: searchValue,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      setAgencies(response.data.data);
    } catch (error) {
      console.error("Error fetching agencies:", error);
    }
  };

  const navigateToAgencyDetails = (agency) => {
    navigation.navigate("Détails", { navigation, token, agency });
  };

  const renderAgencyItem = ({ item }) => (
    <TouchableOpacity
      style={styles.customCard}
      onPress={() => navigateToAgencyDetails(item)}
    >
      <Text style={styles.agencyName}>{item.name}</Text>
      <Text style={styles.agencyAddress}>{item.adresse}</Text>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <View>
        <Text style={styles.title}>Vous avez cherché : "{searchValue}"</Text>
      </View>
      <FlatList
        data={agencies}
        renderItem={renderAgencyItem}
        keyExtractor={(item) => item.id.toString()}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
  },
  customCard: {
    padding: 15,
    marginBottom: 10,
    borderRadius: 10,
    backgroundColor: "white",
    shadowColor: "#000", // On iOS
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5, // On Android
    alignItems: "flex-start",
  },
  agencyItem: {
    borderBottomWidth: 1,
    borderBottomColor: "#ccc",
    paddingVertical: 10,
  },
  agencyName: {
    fontSize: 18,
    fontWeight: "bold",
  },
  agencyAddress: {
    fontSize: 14,
    color: "#666",
  },
});

export default AgencyListScreen;
