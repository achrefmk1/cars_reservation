import React, { useState } from "react";
import {
    View,
    Text,
    TouchableOpacity,
    StyleSheet,
    TextInput,
    Button,
} from "react-native";
import { AntDesign, FontAwesome, MaterialIcons } from "@expo/vector-icons";

const HomeScreen = ({ navigation, route }) => {
    const token = route.params.user.token;
    const user = route.params.user;
    const [searchValue, setsearchValue] = useState("");

    const handleSearch = async () => {
        navigation.navigate("Résultats", { user, searchValue });
    };
    return (
        <View style={styles.container}>
            <View style={styles.content}>
                <Text style={styles.title}>Bonjour {user.name}</Text>
                <Text style={styles.subtitle}>vous cherchez une agence ?</Text>
                <TextInput
                    placeholder="entrer votre emplacement"
                    value={searchValue}
                    onChangeText={setsearchValue}
                    style={styles.input}
                />
                <View style={styles.searchButton}>
                    <TouchableOpacity onPress={handleSearch}>
                        Chercher
                    </TouchableOpacity>
                </View>
            </View>
            <View style={styles.buttonContainer}>
                <TouchableOpacity style={styles.button}>
                    <AntDesign name="home" size={24} color="black" />
                    <Text style={styles.buttonLabel}>Accueil</Text>
                </TouchableOpacity>
                {user.role === "admin" ? (
                    <TouchableOpacity
                        style={styles.button}
                        onPress={() =>
                            navigation.navigate("Utilisateurs", { user })
                        }
                    >
                        <AntDesign name="user" size={24} color="black" />
                        <Text style={styles.buttonLabel}>Utilisateurs</Text>
                    </TouchableOpacity>
                ) : (
                    ""
                )}
                {user.role === "manager" || user.role === "admin" ? (
                    <TouchableOpacity
                        style={styles.button}
                        onPress={() =>
                            navigation.navigate("Mes Agences", { user })
                        }
                    >
                        <FontAwesome name="building" size={24} color="black" />
                        <Text style={styles.buttonLabel}>Agences</Text>
                    </TouchableOpacity>
                ) : (
                    ""
                )}
                <TouchableOpacity
                    style={styles.button}
                    onPress={() =>
                        navigation.navigate("Mes Voitures", { user })
                    }
                >
                    <MaterialIcons
                        name="directions-car"
                        size={24}
                        color="black"
                    />
                    <Text style={styles.buttonLabel}>Voitures</Text>
                </TouchableOpacity>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: "#fff",
    },
    content: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
    },
    title: {
        fontSize: 20,
        fontWeight: "bold",
        marginBottom: 20,
    },
    subtitle: {
        fontSize: 16,
        fontWeight: "bold",
        marginBottom: 20,
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
    searchButton: {},
    searchButton: {
        margin: 10,
        backgroundColor: "#183658",
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 5,
        alignItems: "center",
        color: "white",
    },
});

export default HomeScreen;
