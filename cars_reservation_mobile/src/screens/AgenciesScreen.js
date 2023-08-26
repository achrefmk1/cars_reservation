import React, { useState, useEffect } from "react";
import { View, Text, FlatList, StyleSheet } from "react-native";

const AgenciesScreen = ({ navigation, route }) => {
  const token = route.params.token;
  const [agencies, setAgencies] = useState([]);

  useEffect(() => {
    // Fetch data from the API endpoint
    fetch("http://127.0.0.1:8000/api/agencies", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data.data);
        setAgencies(data.data);
      })
      .catch((error) => console.error("Error fetching data:", error));
  }, []);

  return (
    <View style={styles.container}>
      <FlatList
        data={agencies}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.agencyItem}>
            <Text style={styles.agencyName}>{item.name}</Text>
            <Text style={styles.agencyAdress}>{item.adresse}</Text>
          </View>
        )}
      />
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
  agencyItem: {
    marginBottom: 20,
    borderBottomWidth: 1,
    borderBottomColor: "#ccc",
  },
  agencyName: {
    fontSize: 18,
    fontWeight: "bold",
  },
  agencyAdress: {
    fontSize: 16,
    color: "#666",
  },
});

export default AgenciesScreen;
