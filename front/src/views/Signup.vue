<template>
  <div>
    <v-container class="text-center justify-center py-6">
      <h1>新規登録ページ</h1>
      <v-card-text class="text-center white">
        <v-row>
          <v-col cols="2"></v-col>
          <v-col cols="8">
            <br />
            <v-text-field label="name" v-model="name"> </v-text-field>
            <br />
            <v-text-field label="email" v-model="email"> </v-text-field>
            <br />
            <v-text-field label="password" v-model="password"> </v-text-field>
            <br />
            <v-text-field
              label="password_confirmation"
              v-model="password_confirmation"
            >
            </v-text-field>
            <br />
            <v-btn @click="register">新規作成</v-btn>
            <br />
          </v-col>
          <v-col cols="2"></v-col>
        </v-row>
      </v-card-text>
    </v-container>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      name: null,
      email: null,
      password: null,
      password_confirmation: null,
    };
  },
  methods: {
    register: function () {
      const url = process.env.VUE_APP_URL + "/api/auth";
      var params = new URLSearchParams();
      params.append("name", this.name);
      params.append("email", this.email);
      params.append("password", this.password);
      params.append("password_confirmation", this.password_confirmation);
      axios.defaults.headers.common["Content-Type"] = "application/json";
      axios.post(url, params).then(
        (response) => {
          localStorage.setItem(
            "access-token",
            response.headers["access-token"]
          );
          localStorage.setItem("client", response.headers["client"]);
          localStorage.setItem("uid", response.headers["uid"]);
          localStorage.setItem("token-type", response.headers["token-type"]);
          window.location.href = "/work";
        },
        (error) => {
          console.log(error);
          return error;
        }
      );
    },
  },
};
</script>
