<template>
  <div>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Work Register</h1>
      <v-row>
        <v-col cols="3"></v-col>
        <v-col cols="6">
          <v-text-field label="Work_name" v-model="name"> </v-text-field>
          <v-text-field label="Number of people" v-model="limit">
          </v-text-field>
          <v-text-field label="Day" v-model="day"> </v-text-field>
          <v-text-field label="money" v-model="money"> </v-text-field>
          <v-text-field label="Where" v-model="where"> </v-text-field>
          <v-text-field label="Carfare" v-model="carfare"> </v-text-field>
          <v-text-field label="content" v-model="content"> </v-text-field>
          <v-text-field label="cloth" v-model="cloth"> </v-text-field>
          <v-text-field label="belonging" v-model="belonging"> </v-text-field>
          <v-text-field label="other" v-model="other"> </v-text-field>
          <v-btn @click="register">register</v-btn>
        </v-col>
        <v-col cols="3"></v-col>
      </v-row>
    </v-container>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      name: null,
      limit: null,
      day: null,
      where: null,
      carfare: null,
      content: null,
      cloth: null,
      belonging: null,
      other: null,
    };
  },
  methods: {
    register: function () {
      const url = process.env.VUE_APP_URL;
      var params = {
        name: this.name,
        limit: this.limit,
        day: this.day,
        money: this.money,
        where: this.where,
        carfare: this.carfare,
        content: this.content,
        cloth: this.cloth,
        belonging: this.belonging,
        other: this.other,
      };
      axios
        .post(url + "/works", params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log("succece");
          console.log(response);
        });
    },
  },
};
</script>
