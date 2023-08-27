import axios from "axios";
import React, { useState, useEffect } from "react";
import { View, Text, FlatList, StyleSheet } from "react-native";

const CarHistoryScreen = ({ navigation, route }) => {
    const { item, user } = route.params;
    const token = user.token;
    const [appointments, setAppointments] = useState([]);

    useEffect(async () => {
        await axios
            .get("http://127.0.0.1:8000/api/rdv/getCarHistory/" + item.id, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            })
            .then((resp) => {
                setAppointments(resp.data.data);
            });
    }, []);

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Voiture : mercedes E63s</Text>

            {appointments.length === 0 ? (
                <Text>Aucun historique .</Text>
            ) : (
                <View>
                    <FlatList
                        data={appointments}
                        keyExtractor={(item) => item.id.toString()}
                        renderItem={({ item }) => (
                            <View style={styles.customCard}>
                                <Text style={styles.appointmentInfo}>
                                    {item.agency.name}
                                </Text>
                                <Text style={styles.appointmentInfo}>
                                    {item.service}
                                </Text>
                                <Text style={styles.appointmentInfo}>
                                    Date : {item.date} {item.start.slice(0, 5)}
                                </Text>
                            </View>
                        )}
                    />
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
