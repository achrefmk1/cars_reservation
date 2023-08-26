import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  Picker,
  StyleSheet,
  ImageBackground,
} from "react-native";
import axios from "axios";

const RegisterScreen = () => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState("user");

  const handleRegister = async () => {
    try {
      await axios
        .post("http://127.0.0.1:8000/api/register", {
          name,
          email,
          password,
          phone,
          role,
        })
        .then((resp) => {
          navigation.navigate("Se Connecter");
        });
      // Store the token in AsyncStorage or secure storage
    } catch (error) {
      console.error("Register error:", error);
    }
  };

  return (
    <ImageBackground
      source={require("../assets/bg.jpg")}
      style={styles.backgroundImage}
    >
      <View style={styles.container}>
        <TextInput
          style={styles.input}
          placeholder="Name"
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
          placeholder="Phone"
          value={phone}
          onChangeText={setPhone}
          keyboardType="phone-pad"
        />
        <TextInput
          style={styles.input}
          placeholder="Password"
          value={password}
          onChangeText={setPassword}
          secureTextEntry
        />
        <Picker
          selectedValue={role}
          style={styles.rolePicker}
          onValueChange={(itemValue) => setRole(itemValue)}
        >
          <Picker.Item label="Utilisateur" value="user" />
          <Picker.Item label="Chef d'agence" value="manager" />
        </Picker>
        <TouchableOpacity onPress={handleRegister} style={styles.button}>
          <Text style={styles.registerButtonText}>Register</Text>
        </TouchableOpacity>
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
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
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
  text: {
    fontSize: 16,
  },
  rolePicker: {
    width: 200,
    height: 40,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    marginBottom: 10,
  },
  registerButton: {
    backgroundColor: "#007AFF",
    padding: 10,
    borderRadius: 5,
    alignItems: "center",
  },
  registerButtonText: {
    color: "#fff",
    fontWeight: "bold",
  },
  button: {
    backgroundColor: "#183658",
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
    alignItems: "center",
    color: "white",
  },
});

export default RegisterScreen;
