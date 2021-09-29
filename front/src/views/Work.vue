<template>
<div>
<h1>Work</h1>
</div>
</template>

<script>
import axios from "axios"
export  default{

  data(){

  },
  mounted: function(){
    const url = process.env.VUE_APP_URL;
    axios.get(url + "/works",{
     headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
    })
    .then((response) =>{
    console.log(response);
    })
    .then((error)=>{
      console.log(url);
      console.log(error);
    });
  },
};
</script>