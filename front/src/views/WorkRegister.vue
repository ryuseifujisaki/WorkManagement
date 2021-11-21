<template>
  <div>
    <AdminHeader></AdminHeader>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Work Register</h1>
      <p align="right">管理者専用ページ</p>
      <p align="right">{{ this.userName }}</p>
      <p align="right"><a href="/">user signin page</a></p>
      <v-row>
        <v-col cols="3"></v-col>
        <v-col cols="6">
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-text-field
              label="Work_name"
              v-model="name"
              :rules="rules"
              required
            >
            </v-text-field>
            <v-text-field
              label="Number of people"
              v-model="limit"
              :rules="rules"
              required
            >
            </v-text-field>
            <v-text-field label="Day" v-model="day" :rules="rules" required>
            </v-text-field>
            <v-text-field label="money" v-model="money" :rules="rules" required>
            </v-text-field>
            <v-text-field label="Where" v-model="where" :rules="rules" required>
            </v-text-field>
            <v-text-field label="Carfare" v-model="carfare" required>
            </v-text-field>
            <v-text-field
              label="content"
              v-model="content"
              :rules="rules"
              required
            >
            </v-text-field>
            <v-text-field label="cloth" v-model="cloth" :rules="rules" required>
            </v-text-field>
            <v-text-field label="belonging" v-model="belonging"> </v-text-field>
            <v-text-field label="other" v-model="other"> </v-text-field>
            <v-btn @click="register()">register</v-btn>
          </v-form>
        </v-col>
        <v-col cols="3"></v-col>
      </v-row>
    </v-container>
  </div>
</template>
<script>
import axios from "axios";
import AdminHeader from "@/components/AdminHeader.vue";
export default {
  data() {
    return {
      userName: "",
      name: "",
      limit: "",
      day: "",
      money: "",
      where: "",
      carfare: "",
      content: "",
      cloth: "",
      belonging: "",
      other: "",
      flag: null,
      valid: false,
      //rule規則
      rules: [(v) => !!v || "必須項目"],
    };
  },
  components: {
    AdminHeader,
  },
  methods: {
    register: function () {
      if (this.valid == true) {
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
            location.reload();
          });
      }
    },
    //入力規制
    validate() {
      this.$refs.form.validate();
      console.log(this.valid);
    },
  },
  mounted: function () {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/current_admin/get_admin_signin", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.flag = response.data.flag;
        if (this.flag == false) {
          this.$router.push("/adminsignin");
        }
      });
    axios
      .get(url + "/api/v1/current_admin/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.userName = response.data.data.name;
        console.log(this.userName);
      });
    this.validate();
  },
};
</script>
