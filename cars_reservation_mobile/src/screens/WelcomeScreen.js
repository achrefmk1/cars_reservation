import React, { useState } from "react";
import {
    View,
    Text,
    TouchableOpacity,
    StyleSheet,
    TextInput,
    Button,
    Image,
} from "react-native";
import { AntDesign, FontAwesome, MaterialIcons } from "@expo/vector-icons";
import axios from "axios";

const WelcomeScreen = ({ navigation }) => {
    const [searchValue, setsearchValue] = useState("");
    const [agencies, setAgencies] = useState([]);
    const [loaded, setLoaded] = useState(false);

    const handleSearch = async () => {
        try {
            const response = await axios.post(
                "http://127.0.0.1:8000/api/agencies/find",
                {
                    adresse: searchValue,
                }
            );
            setAgencies(response.data.data);
            setLoaded(true);
        } catch (error) {
            console.error("Error fetching agencies:", error);
        }
    };
    return (
        <View style={styles.container}>
            <View style={styles.content}>
                <Image
                    source={require("../assets/logo.png")}
                    style={styles.image}
                />
                <Text style={styles.title}>Bonjour !</Text>
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
                {loaded ? (
                    agencies.length > 0 ? (
                        <>
                            <Text style={styles.subtitle}>
                                il y a {agencies.length} agences dans cet
                                endroit
                            </Text>
                            <Text style={styles.subtitle}>
                                Veuillez connecterpour voir les détails
                            </Text>
                        </>
                    ) : (
                        <>
                            <Text style={styles.subtitle}>
                                aucune agence trouvée
                            </Text>
                        </>
                    )
                ) : (
                    ""
                )}
            </View>
            <View style={styles.buttonContainer}>
                <TouchableOpacity style={styles.registerButton}>
                    <Text
                        style={styles.buttonLabel}
                        onPress={() => navigation.navigate("Se Connecter")}
                    >
                        Se connecter
                    </Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.registerButton}
                    onPress={() => navigation.navigate("Inscription")}
                >
                    <Text style={styles.buttonLabel}>S'inscrire</Text>
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
        backgroundColor: "#183658",
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 5,
        alignItems: "center",
        color: "white",
    },
    registerButton: {
        color: "blue",
        fontSize: 16,
        paddingVertical: 5,
        paddingHorizontal: 10,
        borderRadius: 5,
        borderWidth: 1,
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
    searchButton: {
        margin: 10,
        backgroundColor: "#183658",
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 5,
        alignItems: "center",
        color: "white",
    },
    image: {
        width: 200,
        height: 200,
        resizeMode: "contain",
    },
});

export default WelcomeScreen;
