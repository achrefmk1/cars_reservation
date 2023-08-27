import React, { useState } from "react";
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    Picker,
    StyleSheet,
} from "react-native";
import axios from "axios";

const AddUserScreen = ({ navigation, route }) => {
    const { user } = route.params;
    const token = user.token;
    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [phone, setPhone] = useState("");
    const [password, setPassword] = useState("");
    const [role, setRole] = useState("user");

    const handleSaveChanges = async () => {
        try {
            await axios
                .post(
                    "http://127.0.0.1:8000/api/register",
                    {
                        name,
                        email,
                        password,
                        phone,
                        role,
                    },
                    {
                        headers: {
                            Authorization: `Bearer ${token}`,
                        },
                    }
                )
                .then((resp) => {
                    navigation.navigate("Utilisateurs", { user });
                });
        } catch (error) {
            console.error("Create User error:", error);
        }
    };

    return (
        <View style={styles.container}>
            <TextInput
                style={styles.input}
                placeholder="Nom"
                value={name}
                onChangeText={setName}
            />
            <TextInput
                style={styles.input}
                placeholder="Email"
                value={email}
                onChangeText={setEmail}
                keyboardType="email-address"
            />
            <TextInput
                style={styles.input}
                placeholder="Téléphone"
                value={phone}
                onChangeText={setPhone}
                keyboardType="phone-pad"
            />
            <TextInput
                style={styles.input}
                placeholder="Mot de passe"
                value={password}
                onChangeText={setPassword}
                secureTextEntry
            />
            <Picker
                selectedValue={role}
                style={styles.rolePicker}
                onValueChange={(itemValue) => setRole(itemValue)}
            >
                <Picker.Item label="Admin" value="admin" />
                <Picker.Item label="Utilisateur" value="user" />
                <Picker.Item label="Chef d'agence" value="manager" />
            </Picker>
            <TouchableOpacity onPress={handleSaveChanges} style={styles.button}>
                <Text style={styles.saveButtonText}>Save Changes</Text>
            </TouchableOpacity>
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
    input: {
        height: 40,
        borderWidth: 1,
        borderColor: "#ccc",
        borderRadius: 5,
        marginBottom: 10,
        paddingHorizontal: 10,
    },
    rolePicker: {
        height: 40,
        borderWidth: 1,
        borderColor: "#ccc",
        borderRadius: 5,
        marginBottom: 10,
    },
    saveButton: {
        backgroundColor: "#007AFF",
        padding: 10,
        borderRadius: 5,
        alignItems: "center",
    },
    saveButtonText: {
        color: "#fff",
        fontWeight: "bold",
    },
});

export default AddUserScreen;
