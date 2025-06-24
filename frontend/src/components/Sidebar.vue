<script setup lang="ts">
import { RouterLink } from 'vue-router'
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useSidebarStore } from '@/stores/sidebar'
import { onClickOutside } from '@vueuse/core'

const sidebarStore = useSidebarStore()
const sidebarRef = ref(null)

onClickOutside(sidebarRef, () => {
	sidebarStore.close()
})

</script>

<template>
	<div class="sidebar has-background-grey is-100" :class="{'is-open': sidebarStore.isOpen}" ref="sidebarRef">
		<aside class="menu">
			<p class="menu-label">Menu</p>
			<ul class="menu-list">
				<li>
					<RouterLink to="/" active-class="is-active">
						<span class="icon-text">
							<span class="icon">
								<i class="fas fa-home"></i>
							</span>
							<span>Home</span>
						</span>
					</RouterLink>
				</li>
				<li><RouterLink to="/about" active-class="is-active">About</RouterLink></li>
			</ul>
		</aside>
	</div>
</template>

<style lang="scss">
@use 'bulma/sass/utilities/initial-variables' as iv;
@use 'bulma/sass/utilities/derived-variables' as dv;

@media screen and (max-width: iv.$tablet) {
	.sidebar {
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		width: 250px;
		z-index: 100;
		transition: transform 0.3s ease;
		transform: translateX(-100%);
		// background-color: dv.$background;
	}

	.sidebar.is-open {
		transform: translateX(0);
	}
}
</style>
