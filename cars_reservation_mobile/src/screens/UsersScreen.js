import React, { useState, useEffect } from "react";
import {
    View,
    Text,
    FlatList,
    TouchableOpacity,
    StyleSheet,
} from "react-native";
import { Feather, FontAwesome5 } from "@expo/vector-icons";
import axios from "axios";

const UsersScreen = ({ navigation, route }) => {
    const { user } = route.params;
    const token = user.token;
    const [users, setUsers] = useState([]);

    useEffect(() => {
        getUsers();
    }, []);

    async function getUsers() {
        await axios
            .get("http://127.0.0.1:8000/api/users", {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            })
            .then((resp) => {
                setUsers(resp.data.data);
            });
    }

    const handleDisableUser = async (userId) => {
        // Handle the disable action for the user with userId toggleStatus
        console.log(`Disable user with ID ${userId}`);
        await axios
            .post(
                "http://127.0.0.1:8000/api/users/toggleStatus/" + userId,
                {},
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                }
            )
            .then((resp) => {
                getUsers();
            });
    };

    return (
        <View style={styles.container}>
            <TouchableOpacity
                onPress={() =>
                    navigation.navigate("Nouveau Utilisateur", { token })
                }
                style={styles.button}
            >
                <Text style={styles.saveButtonText}>Créer un Utilisateur</Text>
            </TouchableOpacity>
            <FlatList
                data={users}
                keyExtractor={(item) => item.id.toString()}
                renderItem={({ item }) => (
                    <View style={styles.userItem}>
                        <Text style={styles.userName}>{item.name}</Text>
                        <TouchableOpacity
                            onPress={() =>
                                navigation.navigate("Modifier", {
                                    token,
                                    user: item,
                                })
                            }
                            style={styles.actionButton}
                        >
                            <Feather name="edit" size={20} color="#007AFF" />
                        </TouchableOpacity>
                        <TouchableOpacity
                            onPress={() => handleDisableUser(item.id)}
                            style={styles.actionButton}
                        >
                            {item.isEnabled === "yes" ? (
                                <Feather
                                    name="user-check"
                                    size={24}
                                    color="green"
                                />
                            ) : (
                                <FontAwesome5
                                    name="user-slash"
                                    size={24}
                                    color="red"
                                />
                            )}
                        </TouchableOpacity>
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
    button: {
        backgroundColor: "#183658",
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 5,
        alignItems: "center",
        color: "white",
    },
    title: {
        fontSize: 24,
        fontWeight: "bold",
        marginBottom: 20,
    },
    userItem: {
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 20,
        borderBottomWidth: 1,
        borderBottomColor: "#ccc",
    },
    userName: {
        fontSize: 18,
        fontWeight: "bold",
        flex: 1,
    },
    actionButton: {
        marginLeft: 10,
    },
    saveButton: {
        backgroundColor: "#007AFF",
        padding: 10,
        borderRadius: 5,
        alignItems: "center",
        marginBottom: 30,
    },
    saveButtonText: {
        color: "#fff",
        fontWeight: "bold",
    },
});

export default UsersScreen;
