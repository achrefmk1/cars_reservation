import React, { useState, useEffect } from "react";
import { View, Text, FlatList, StyleSheet } from "react-native";

const CarHistoryScreen = () => {
  const [appointments, setAppointments] = useState([]);

  //   useEffect(() => {
  //     // Fetch historical appointments from your API
  //     const fetchAppointments = async () => {
  //       try {
  //         // Replace with your API endpoint
  //         const response = await fetch("http://your-api-endpoint");
  //         const data = await response.json();
  //         setAppointments(data);
  //       } catch (error) {
  //         console.error("Error fetching appointments:", error);
  //       }
  //     };

  //     fetchAppointments();
  //   }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Voiture : mercedes E63s</Text>

      {appointments.length < 0 ? (
        <Text>Aucun historique .</Text>
      ) : (
        <View>
          <View style={styles.customCard}>
            <Text style={styles.appointmentInfo}>Agence Mercedes</Text>
            <Text style={styles.appointmentInfo}>Lavage</Text>
            <Text style={styles.appointmentInfo}>Date : 12-07-2023 10:00</Text>
          </View>
          <View style={styles.customCard}>
            <Text style={styles.appointmentInfo}>Agence Mercedes</Text>
            <Text style={styles.appointmentInfo}>Vidange</Text>
            <Text style={styles.appointmentInfo}>Date : 28-05-2023 09:00</Text>
          </View>
          <View style={styles.customCard}>
            <Text style={styles.appointmentInfo}>Agence CleanCar</Text>
            <Text style={styles.appointmentInfo}>Lavage</Text>
            <Text style={styles.appointmentInfo}>Date : 01-02-2023 12:00</Text>
          </View>
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  customCard: {
    padding: 15,
    marginBottom: 15,
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
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
  },
  appointmentItem: {
    backgroundColor: "#f5f5f5",
    padding: 10,
    marginBottom: 10,
    borderRadius: 5,
  },
  appointmentInfo: {
    fontSize: 16,
  },
});

export default CarHistoryScreen;
