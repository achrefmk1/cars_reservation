import React, { useEffect, useState } from "react";
import {
    View,
    Text,
    Picker,
    TextInput,
    TouchableOpacity,
    StyleSheet,
} from "react-native";
import axios from "axios";
import DatePicker from "react-datepicker";

import "react-datepicker/dist/react-datepicker.css";

const RDVScreen = ({ navigation, route }) => {
    const { agency, service, user } = route.params;
    const token = user.token;
    const [selectedOption, setSelectedOption] = useState("1");
    const [selectedDate, setSelectedDate] = useState("");
    const [start, setStart] = useState("");
    const [end, setEnd] = useState("");
    const [cars, setCars] = useState([]);
    const [loaded, setLoaded] = useState(false);
    const [msg, setMsg] = useState(false);
    const [checked, setChecked] = useState(false);

    useEffect(() => {
        getCars();
    }, []);

    async function getCars() {
        await axios
            .get("http://127.0.0.1:8000/api/cars", {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            })
            .then((resp) => {
                setCars(resp.data.data);
            });
    }

    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, "0");
        const day = date.getDate().toString().padStart(2, "0");
        return `${year}-${month}-${day}`;
    };

    const handleSaveRDV = async () => {
        if (checked) {
            await axios
                .post(
                    "http://127.0.0.1:8000/api/rdv/store",
                    {
                        service: service.service,
                        agency_id: agency.id,
                        car_id: selectedOption,
                        date: formatDate(selectedDate),
                        start,
                        end,
                    },
                    {
                        headers: {
                            Authorization: `Bearer ${token}`,
                        },
                    }
                )
                .then((resp) => {
                    navigation.navigate("Accueil", { user });
                });
        } else {
            await axios
                .post(
                    "http://127.0.0.1:8000/api/rdv/" + agency.id,
                    {
                        service: service.service,
                        agency_id: agency.id,
                        car_id: selectedOption,
                        date: formatDate(selectedDate),
                    },
                    {
                        headers: {
                            Authorization: `Bearer ${token}`,
                        },
                    }
                )
                .then((resp) => {
                    setLoaded(true);
                    if (resp.data.available === true) {
                        setChecked(true);
                        setStart(resp.data.start);
                        setEnd(resp.data.end);
                    } else {
                        setChecked(false);
                    }
                    setMsg(resp.data.message);
                });
        }
    };

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Rendez-vous chez "{agency.name}"</Text>
            <Text style={styles.subtitle}>pour "{service.service}"</Text>

            <View style={styles.formGroup}>
                <Text style={styles.label}>Selectionner ta voiture:</Text>
                <Picker
                    style={styles.carPicker}
                    selectedValue={selectedOption}
                    onValueChange={(itemValue) => setSelectedOption(itemValue)}
                >
                    {cars.map((car, index) => (
                        <Picker.Item
                            key={index}
                            label={car.model}
                            value={car.id}
                        />
                    ))}
                </Picker>
            </View>

            <View style={styles.formGroup}>
                <Text style={styles.label}>Selectionner la Date:</Text>
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
            {loaded && (
                <Text style={checked ? styles.success : styles.danger}>
                    {msg}
                </Text>
            )}

            <TouchableOpacity style={styles.button} onPress={handleSaveRDV}>
                Vérifier
            </TouchableOpacity>
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
        marginBottom: 15,
    },
    danger: {
        color: "#fa5858",
    },
    success: {
        color: "#4cbb8a",
    },
    subtitle: {
        fontSize: 18,
        fontWeight: "bold",
        marginBottom: 20,
    },
    formGroup: {
        marginBottom: 20,
    },
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
    carPicker: {
        width: 200,
        height: 40,
        borderWidth: 1,
        borderColor: "#ccc",
        borderRadius: 5,
        marginBottom: 10,
    },
});

export default RDVScreen;
