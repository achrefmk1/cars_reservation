import React, { useState, useEffect } from "react";
import {
    View,
    Text,
    FlatList,
    Button,
    TextInput,
    StyleSheet,
    TouchableOpacity,
} from "react-native";
import DatePicker from "react-datepicker";

import "react-datepicker/dist/react-datepicker.css";
import moment from "moment";
import axios from "axios";

const DaysOffScreen = ({ navigation, route }) => {
    const { agency, user } = route.params;
    const token = user.token;
    const [daysOff, setDaysOff] = useState([]);
    const [name, setName] = useState("");
    const [selectedDate, setSelectedDate] = useState("");

    const fetchDaysOff = async () => {
        try {
            const response = await axios.get(
                "http://127.0.0.1:8000/api/agencies/days/" + agency.id,
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                }
            );
            setDaysOff(response.data);
        } catch (error) {
            console.error("Error fetching days off:", error);
        }
    };

    const handleAddDayOff = async () => {
        console.log(selectedDate);
        try {
            const response = await axios.post(
                "http://127.0.0.1:8000/api/days",
                {
                    name,
                    date: moment(selectedDate).format("YYYY-MM-DD"),
                    agency_id: agency.id,
                },
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                }
            );

            if (response.status === 201) {
                // Day off added successfully
                fetchDaysOff();
                setName("");
                // setSelectedDate("");
            } else {
                console.error("Failed to add day off");
            }
        } catch (error) {
            console.error("Error adding day off:", error);
        }
    };

    useEffect(() => {
        fetchDaysOff();
    }, []);

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Bienvenue chez : {agency.name}</Text>

            <View style={styles.formGroup}>
                <Text style={styles.label}>Name:</Text>
                <TextInput
                    value={name}
                    onChangeText={setName}
                    style={styles.input}
                />
            </View>

            <View style={styles.formGroup}>
                <Text style={styles.label}>Select a Date:</Text>
                <DatePicker
                    style={styles.datePicker}
                    selected={selectedDate}
                    onChange={(date) => {
                        console.log(date);
                        setSelectedDate(date);
                    }}
                    dateFormat="yyyy-MM-dd"
                    popperPlacement="top"
                />
            </View>

            <TouchableOpacity style={styles.button} onPress={handleAddDayOff}>
                Enregistrer
            </TouchableOpacity>

            <FlatList
                data={daysOff}
                keyExtractor={(item) => item.id.toString()}
                renderItem={({ item }) => (
                    <View style={styles.dayOffItem}>
                        <Text style={styles.dayOffName}>{item.name}</Text>
                        <Text style={styles.dayOffDate}>{item.date}</Text>
                    </View>
                )}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
    },
    button: {
        backgroundColor: "#183658",
        paddingVertical: 10,
        paddingHorizontal: 20,
        borderRadius: 5,
        alignItems: "center",
        color: "white",
        marginTop: 15,
    },
    title: {
        fontSize: 24,
        fontWeight: "bold",
        marginBottom: 20,
    },
    // formGroup: {
    //   marginBottom: 20,
    // },
    label: {
        fontSize: 16,
        marginBottom: 5,
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
    datePicker: {
        width: 200,
        height: 40,
        borderColor: "gray",
        borderWidth: 1,
        marginVertical: 10,
        paddingHorizontal: 8,
        backgroundColor: "white",
        opacity: 1,
        justifyContent: "center",
    },
    dayOffItem: {
        backgroundColor: "#f5f5f5",
        padding: 10,
        marginBottom: 10,
        borderRadius: 5,
    },
    dayOffName: {
        fontSize: 16,
        fontWeight: "bold",
    },
    dayOffDate: {
        fontSize: 14,
    },

    formGroup: {
        marginBottom: 20,
    },
    label: {
        fontSize: 16,
        marginBottom: 5,
    },
});

export default DaysOffScreen;
