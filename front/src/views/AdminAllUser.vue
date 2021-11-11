<template>
  <div>
    <AdminHeader></AdminHeader>
    <v-container class="text-center justify-center py-6">
      <h1>All User Information</h1>
      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="8">
          <!-- 検索用のテキスト入力 -->
          <v-text-field
            v-model="search"
            append-icon="mdi-magnify"
            label="検索"
            single-line
            hide-details
          ></v-text-field>
          <v-data-table :headers="headers" :items="users" :search="search">
          </v-data-table>
        </v-col>
        <v-col cols="2"></v-col>
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
      users: [],
      search: null,
      name: null,
      grade: null,
      course: null,
      email: null,
      headers: [
        {
          text: "name",
          align: "start",
          sortable: "false",
          value: "name",
        },
        {
          text: "grade",
          align: "start",
          sortable: "false",
          value: "grade",
        },
        {
          text: "course",
          align: "start",
          sortable: "false",
          value: "course",
        },
        {
          text: "email",
          align: "start",
          sortable: "false",
          value: "email",
        },
      ],
    };
  },
  components: {
    AdminHeader,
  },
  mounted: async function () {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/current_user/index", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response.data.data);
        this.users = response.data.data;
      });
  },
};
</script>
