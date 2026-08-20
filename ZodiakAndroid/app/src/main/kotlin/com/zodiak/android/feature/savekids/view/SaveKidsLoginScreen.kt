package com.zodiak.android.feature.savekids.view

import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.zodiak.android.design_system.atoms.ZodiakButton
import com.zodiak.android.design_system.molecules.ZodiakInputField
import com.zodiak.android.design_system.organisms.ZodiakFormContainer
import com.zodiak.android.design_system.organisms.ZodiakMiniBadge
import com.zodiak.android.design_system.organisms.ZodiakStatTile
import com.zodiak.android.design_system.theme.ZodiakSpacing
import com.zodiak.android.feature.savekids.viewmodel.SaveKidsLoginViewModel

@Composable
fun SaveKidsLoginScreen(
    onBack: () -> Unit,
    onGoToHome: () -> Unit,
    viewModel: SaveKidsLoginViewModel = hiltViewModel(),
) {
    val state by viewModel.uiState.collectAsStateWithLifecycle()

    if (state.success) {
        onGoToHome()
    }

    Scaffold { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = ZodiakSpacing.screenPad),
            verticalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(vertical = ZodiakSpacing.screenPad),
        ) {
            item { SaveKidsBackButton(onBack) }

            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(22.dp),
                    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                ) {
                    Column(modifier = Modifier.padding(14.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                        Surface(
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(20.dp),
                            color = MaterialTheme.colorScheme.surfaceVariant,
                        ) {
                            Row(modifier = Modifier.padding(ZodiakSpacing.s4), horizontalArrangement = Arrangement.spacedBy(6.dp)) {
                                Box(
                                    modifier = Modifier
                                        .weight(1f)
                                        .clip(RoundedCornerShape(14.dp))
                                        .background(if (state.isRegistrationMode) MaterialTheme.colorScheme.surfaceVariant else MaterialTheme.colorScheme.surface)
                                        .clickable { if (state.isRegistrationMode) viewModel.onToggleRegistration() }
                                        .padding(vertical = 10.dp),
                                ) {
                                    Text(
                                        "Entrar",
                                        modifier = Modifier.align(androidx.compose.ui.Alignment.Center),
                                        style = MaterialTheme.typography.labelLarge,
                                        color = if (state.isRegistrationMode) MaterialTheme.colorScheme.onSurfaceVariant else MaterialTheme.colorScheme.onSurface,
                                    )
                                }
                                Box(
                                    modifier = Modifier
                                        .weight(1f)
                                        .clip(RoundedCornerShape(14.dp))
                                        .background(if (state.isRegistrationMode) MaterialTheme.colorScheme.surface else MaterialTheme.colorScheme.surfaceVariant)
                                        .clickable { if (!state.isRegistrationMode) viewModel.onToggleRegistration() }
                                        .padding(vertical = 10.dp),
                                ) {
                                    Text(
                                        "Cadastro",
                                        modifier = Modifier.align(androidx.compose.ui.Alignment.Center),
                                        style = MaterialTheme.typography.labelLarge,
                                        color = if (state.isRegistrationMode) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onSurfaceVariant,
                                    )
                                }
                            }
                        }

                        if (!state.authStepDone) {
                            if (state.isRegistrationMode) {
                                Text("Crie a conta da sua família", style = MaterialTheme.typography.headlineSmall)
                                Text(
                                    "Cadastre o responsável e comece a acompanhar as conquistas da criança.",
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                                ZodiakInputField(
                                    value = state.familyName,
                                    onValueChange = viewModel::onFamilyNameChange,
                                    label = "Nome da família",
                                )
                                ZodiakInputField(
                                    value = state.username,
                                    onValueChange = viewModel::onUsernameChange,
                                    label = "E-mail da família",
                                )
                                ZodiakInputField(
                                    value = state.password,
                                    onValueChange = viewModel::onPasswordChange,
                                    label = "Senha ou PIN",
                                    keyboardType = KeyboardType.Password,
                                )
                                ZodiakButton("Criar conta", viewModel::registerAccount, Modifier.fillMaxWidth())
                            } else {
                                Text("Entrar para acompanhar cada conquista", style = MaterialTheme.typography.headlineSmall)
                                Text(
                                    "O responsável registra depósitos e acompanha a evolução junto com a criança.",
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                                ZodiakInputField(
                                    value = state.username,
                                    onValueChange = viewModel::onUsernameChange,
                                    label = "E-mail da família",
                                )
                                ZodiakInputField(
                                    value = state.password,
                                    onValueChange = viewModel::onPasswordChange,
                                    label = "Senha ou PIN",
                                    keyboardType = KeyboardType.Password,
                                )
                                Text(
                                    "Dica: use teste no usuário e senha.",
                                    style = MaterialTheme.typography.bodySmall,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                                ZodiakButton("Entrar como responsável", viewModel::authenticate, Modifier.fillMaxWidth())
                            }
                        }
                    }
                }
            }

            if (state.authStepDone) {
                item {
                    ZodiakFormContainer("Passo 2: perfil inicial da criança") {
                        ZodiakInputField(
                            value = state.childName,
                            onValueChange = viewModel::onChildNameChange,
                            label = "Nome da criança",
                        )
                        Spacer(Modifier.height(ZodiakSpacing.s8))
                        Text("Escolha o Pokémon inicial", style = MaterialTheme.typography.titleMedium)
                        Spacer(Modifier.height(ZodiakSpacing.s8))
                        Column(verticalArrangement = Arrangement.spacedBy(ZodiakSpacing.s8)) {
                            viewModel.starterAvatars.forEach { avatar ->
                                val selected = state.selectedAvatarId == avatar.pokemonId
                                Column(
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .clip(MaterialTheme.shapes.medium)
                                        .border(
                                            width = if (selected) 2.dp else 1.dp,
                                            color = if (selected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.outlineVariant,
                                            shape = MaterialTheme.shapes.medium,
                                        )
                                        .clickable { viewModel.onAvatarSelected(avatar.pokemonId) }
                                        .padding(12.dp),
                                ) {
                                    Text(avatar.teamName, style = MaterialTheme.typography.titleSmall)
                                    Text(
                                        avatar.description,
                                        style = MaterialTheme.typography.bodySmall,
                                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                                    )
                                }
                            }
                        }
                        Spacer(Modifier.height(12.dp))
                        ZodiakButton("Entrar no Save Kids", viewModel::saveProfile, Modifier.fillMaxWidth())
                    }
                }
            }

            state.errorMessage?.let { message ->
                item {
                    Text(
                        text = message,
                        color = MaterialTheme.colorScheme.error,
                        style = MaterialTheme.typography.bodySmall,
                    )
                }
            }

            if (state.isLoading) {
                item { Text("Carregando...", style = MaterialTheme.typography.bodyMedium) }
            }
        }
    }
}
