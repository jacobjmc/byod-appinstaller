<script setup lang="ts">
import { invoke } from "@tauri-apps/api/tauri";
import { onMounted } from "vue";

// call rust function
// const showHello = async () => {
//   hello.value == "hello_test"
//     ? (hello.value = "Click for hello")
//     : (hello.value = (await invoke("hello_world")) as string);
// };

type App = {
  name: string;
  installed: boolean;
  image: string;
};

onMounted(async () => {
  runScript();
});

const apps = ref<App[]>([]);

const runScript = async () => {
  loading.value = true;
  apps.value = await invoke("apps_installed");
  loading.value = false;
};

const appToInstall = async (installApp: App["name"]) => {
  loading.value = true;
  await invoke(installApp);
  runScript();
};

const loading = ref(false);
</script>

<template>
  <div id="app" class="bg-green-100 h-[200vh]">
    <div class="flex justify-center mx-20 rounded-lg">
      <div class="flex flex-col mt-10 w-full rounded-lg">
        <UButton
          class="h-12 shadow-md"
          color="black"
          :loading="loading"
          @click="runScript()"
          ><p>Check if apps are installed</p></UButton
        >

        <div v-if="apps" class="grid grid-cols-1 md:grid-cols-3 md:gap-2">
          <div
            v-for="app in apps"
            class="bg-white shadow-md rounded-lg my-4 md:my-4 h-auto p-4 max-w-xs justify-center flex flex-wrap"
          >
            <img class="h-[100px] my-2" :src="app.image" alt="" />
            <p
              class="basis-full text-center text-2xl font-semibold text-gray-800"
            >
              {{ app.name }}
            </p>
            <p
              v-if="app.installed"
              class="basis-full text-center text-2xl font-semibold bg-green-500 rounded-lg text-white mt-6 py-2"
            >
              Installed
            </p>
            <div v-else class="flex flex-col items-center space-y-2">
              <p
                class="basis-full text-center text-2xl font-semibold bg-red-500 rounded-lg text-white mt-6 py-2 px-14"
              >
                Not Installed
              </p>
              <UButton
                :loading="loading"
                @click="appToInstall(app.name)"
                class="px-10"
                >Install</UButton
              >
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
#app {
  color: black;
}
</style>
