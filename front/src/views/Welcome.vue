<template>
  <div>
    <v-container class="text-center justify-center py-6">
      <h1>Welcome Page</h1>
      <v-btn @click="open">ログイン</v-btn>
      <v-dialog v-model="dialog" max-width="600px">
        <v-card-text class="text-center white">
          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <br />
              <v-text-field label="email"> </v-text-field>
              <br />
              <v-text-field label="password"> </v-text-field>
              <br />
              <v-btn>ログイン</v-btn>
              <br />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>
        </v-card-text>
      </v-dialog>
    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
    };
  },
  methods: {
    open: function () {
      this.dialog = true;
    },
  },
};
</script>
