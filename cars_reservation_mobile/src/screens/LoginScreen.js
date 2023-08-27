import React, { useState } from "react";
import {
    View,
    Text,
    TextInput,
    Button,
    StyleSheet,
    ImageBackground,
    TouchableOpacity,
} from "react-native";
import axios from "axios";

const LoginScreen = ({ navigation }) => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");

    const handleLogin = async () => {
        try {
            await axios
                .post("http://127.0.0.1:8000/api/login", {
                    email,
                    password,
                })
                .then((resp) => {
                    const user = resp.data.user;
                    navigation.navigate("Accueil", { user });
                });
            // Store the token in AsyncStorage or secure storage
        } catch (error) {
            setError("vérifier vos identifiants");
            console.error("Login error:", error);
        }
    };

    return (
        <ImageBackground
            source={require("../assets/bg.jpg")}
            style={styles.backgroundImage}
        >
            <View style={styles.container}>
                <TextInput
                    placeholder="Email"
                    value={email}
                    onChangeText={setEmail}
                    style={styles.input}
                />
                <TextInput
                    placeholder="Password"
                    secureTextEntry
                    value={password}
                    onChangeText={setPassword}
                    style={styles.input}
                />
                <View>
                    <Text style={styles.error}>{error}</Text>
                </View>
                <View style={styles.loginButton}>
                    <TouchableOpacity
                        style={styles.button}
                        onPress={handleLogin}
                    >
                        Connexion
                    </TouchableOpacity>
                </View>
                <View>
                    <Text style={styles.text}>Vous n'avez pas de Compte ?</Text>
                    <TouchableOpacity
                        style={styles.registerButton}
                        onPress={() => navigation.navigate("Inscription")}
                    >
                        S'inscrire
                    </TouchableOpacity>
                </View>
            </View>
        </ImageBackground>
    );
};

const styles = StyleSheet.create({
    backgroundImage: {
        flex: 1,
        resizeMode: "stretch",
        justifyContent: "center",
    },
    error: {
        color: "red",
    },
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
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
    loginButton: {
        margin: 10,
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
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 5,
        borderWidth: 1,
        alignItems: "center",
    },
    text: {
        fontSize: 16,
    },
});

export default LoginScreen;
