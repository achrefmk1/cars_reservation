import React, { useState, useEffect } from "react";
import {
    View,
    Text,
    FlatList,
    TouchableOpacity,
    StyleSheet,
} from "react-native";
import axios from "axios";

const AgencyDetailsScreen = ({ navigation, route }) => {
    const { agency, user } = route.params;
    const token = user.token;
    const [services, setServices] = useState([]);

    useEffect(() => {
        fetchAgencyServices();
    }, []);

    const fetchAgencyServices = async () => {
        try {
            const response = await axios.get(
                "http://127.0.0.1:8000/api/agencies/services/" + agency.id,
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                }
            );
            setServices(response.data);
        } catch (error) {
            console.error("Error fetching agency services :", error);
        }
    };

    const navigateToRDV = (service) => {
        navigation.navigate("RDV", { navigation, user, agency, service });
    };

    const renderServiceItem = ({ item }) => (
        <View>
            {user.id !== agency.user_id ? (
                <TouchableOpacity
                    style={styles.customCard}
                    onPress={() => navigateToRDV(item)}
                >
                    <Text style={styles.serviceName}>{item.service}</Text>
                </TouchableOpacity>
            ) : (
                <TouchableOpacity style={styles.customCard}>
                    <Text style={styles.serviceName}>{item.service}</Text>
                </TouchableOpacity>
            )}
        </View>
    );

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Bienvenue chez : {agency.name}</Text>
            <Text style={styles.subtitle}>Address: {agency.adresse}</Text>
            <Text style={styles.subtitle}>Email: {agency.email}</Text>
            <Text style={styles.subtitle}>Téléphone: {agency.phone}</Text>
            <View style={styles.serviceTitle}>
                <Text style={styles.serviceTitle}>
                    Liste des services disponibles
                </Text>
            </View>
            <FlatList
                data={services}
                renderItem={renderServiceItem}
                keyExtractor={(item) => item.id.toString()}
            />

            {user.id === agency.user_id && (
                <View style={styles.buttonContainer}>
                    <TouchableOpacity style={styles.button}>
                        <Text
                            style={styles.buttonLabel}
                            onPress={() =>
                                navigation.navigate("Mes Services", {
                                    navigation,
                                    user,
                                    agency,
                                })
                            }
                        >
                            Services
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.button}>
                        <Text
                            style={styles.buttonLabel}
                            onPress={() =>
                                navigation.navigate("Jours Fériés", {
                                    navigation,
                                    user,
                                    agency,
                                })
                            }
                        >
                            Jours Fériés
                        </Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.button}>
                        <Text
                            style={styles.buttonLabel}
                            onPress={() =>
                                navigation.navigate("Mes Rendez-vous", {
                                    navigation,
                                    user,
                                    agency,
                                })
                            }
                        >
                            Rendez-vous
                        </Text>
                    </TouchableOpacity>
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
    title: {
        fontSize: 24,
        fontWeight: "bold",
        marginBottom: 10,
    },
    serviceTitle: {
        fontSize: 20,
        fontWeight: "bold",
        marginBottom: 10,
        marginTop: 10,
    },
    subtitle: {
        fontSize: 16,
        // fontWeight: "bold",
        marginTop: 20,
    },
    details: {
        fontSize: 16,
        marginTop: 5,
    },
    serviceItem: {
        borderBottomWidth: 1,
        borderBottomColor: "#ccc",
        padding: 10,
        marginVertical: 5,
        backgroundColor: "#8798ab",
    },
    serviceName: {
        fontSize: 18,
        fontWeight: "bold",
    },
    servicePeriode: {
        fontSize: 14,
        color: "#666",
    },
    buttonContainer: {
        flexDirection: "row",
        justifyContent: "space-around",
        alignItems: "center",
        paddingBottom: 20,
    },
    button: {
        alignItems: "center",
    },
    buttonLabel: {
        marginTop: 5,
        fontSize: 16,
    },
});

export default AgencyDetailsScreen;
